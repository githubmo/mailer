require_relative 'mailer/env'
require_relative 'mailer/models'
require_relative 'mailer/helpers'
require_relative 'mailer/xml_parser'
require 'active_support'
require 'bunny'
require 'multi_json'
require 'uri'
require 'fileutils'
require 'securerandom'

module Blinkbox
  module Mailer
    class Daemon
      def initialize(options)
        @log = options['logger']
        @queue_name = options['email_queue']
        @log.debug "Opening connection to message queue"
        @amqp = { :connection => Bunny.new(options[:mq] || "amqp://guest:guest@127.0.0.1:5672") }
        @amqp[:connection].start
        @log.debug "Opening message channel"
        @amqp[:channel] = @amqp[:connection].create_channel

        @amqp[:channel].prefetch(50)

        ActionMailer::Base.smtp_settings = {
          :address   => options[:smtp_server],
          :port      => options[:smtp_port],
          :authentication => :plain,
          :user_name      => options[:smtp_username],
          :password       => options[:smtp_password],
          :enable_starttls_auto => true
        }

        @resource_server = {
          :write => options[:resource_server_write],
          :http => options[:resource_server_http]
        }
      end

      def start
        @log.info "Listening for email instruction messages"
        queue = @amqp[:channel].queue(@queue_name,
          :durable => true,
          :arguments => {
            "x-dead-letter-exchange" => "#{@queue_name}.DLX"
          }
        )

        queue.subscribe(ack: true, block: true) do |delivery_info, metadata, payload|
          @log.info "Received message (##{delivery_info.delivery_tag})"
          begin
            email_variables = extract_variables(delivery_info, payload)
            process_mail(delivery_info, email_variables) unless email_variables.nil?
          rescue => e
            @amqp[:channel].nack(delivery_info.delivery_tag, false)
            @log.error "Failure to process message (##{delivery_info.delivery_tag}), rejected back to queue (#{e.message})"
            @log.debug "#{e.class}: #{e.message}\n\t#{e.backtrace.join("\n\t")}"
          end
        end
      end

      def extract_variables(delivery_info, payload)
        Blinkbox::Mailer::XmlParser.get_vars_from_xml(payload) || {}
      rescue REXML::ParseException
        @amqp[:channel].nack(delivery_info.delivery_tag, false)
        @log.error "The incoming message (##{delivery_info.delivery_tag}) was incorrectly formed and was rejected back to the queue"
        nil
      end    

      def process_mail(delivery_info, email_variables)
        begin

          raise RuntimeError, "No recipient specified" unless email_variables['to'].any?

          unless Blinkbox::Mailer::Customer.action_methods.include? email_variables['template']
            raise RuntimeError, "No such email template '#{email_variables['template']}'"
          end

          root_folder = ["mails"]
          root_folder.unshift("user:#{email_variables["user_id"]}") if email_variables["user_id"]

          view_online_path = File.join(*(root_folder + SecureRandom.hex(32).scan(/.{4}/))) + ".html"

          local_filename = File.join(@resource_server[:write], view_online_path)

          write_to_resource_server = false

          # ActionStrings track whether they've been used (as a string). This is so that we
          # only write the online copy of the email if a link to it was put in the email.
          email_variables['view_online_url'] = ActionString.new(File.join(@resource_server[:http], view_online_path))

          email = Blinkbox::Mailer::Customer.send(email_variables['template'], email_variables)

          if email_variables['view_online_url'].used?
            unless File.directory?(File.dirname(local_filename))
              FileUtils.mkdir_p(File.dirname(local_filename))
              @log.debug "Made directory #{File.dirname(local_filename)}"
            end

            open(local_filename, 'w') do |f|
              f.write email.html_part.body
            end
            @log.debug "Written email to #{local_filename}"
          end

          email.deliver

          @amqp[:channel].acknowledge(delivery_info.delivery_tag, false)
          @log.info "Email delivered (##{delivery_info.delivery_tag})"

        rescue ActionView::Template::Error => e
          @amqp[:channel].nack(delivery_info.delivery_tag, false)
          @log.error "#{e.message} in the message (##{delivery_info.delivery_tag}) so it was rejected back to the queue"
        end
      end

      def stop
        @amqp[:channel].close
        @amqp[:connection].close
      end
    end
  end
end