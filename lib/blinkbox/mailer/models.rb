module Blinkbox
  module Mailer
    class Customer < ActionMailer::Base
      layout 'october_launch'

      default from: "blinkbox books <no_reply@blinkbox.com>"

      def welcome(variables = {})
        generate_email variables, "Welcome to blinkbox books"
      end



      def receipt(variables = {})
        generate_email variables, "Thank you for choosing blinkbox"
      end

      def password_confirmed(variables = {})
        generate_email variables, "Your blinkbox books password has been changed"
      end

      def password_reset(variables = {})
        generate_email variables, "Resetting your blinkbox books password is easy"
      end

      private

      def generate_email(variables, default_subject)
        @variables = Locals.new(variables["templateVariables"])
        mail(
          to: prepare_recipient(variables['to']),
          subject: variables['subject'] || default_subject
        ) do |format|
          format.html
          format.text
        end
        message_id = variables.select{ |k,v| k.include? ":messageId"}[0]
        headers['X-bbb-message-id'] = message_id
      end

      def prepare_recipient(recipients)
        recipients.collect do |recipient|
          if recipient['name'].nil? || recipient['name'].empty?
            recipient['email']
          else
            "\"#{recipient['name']}\" <#{recipient['email']}>"
          end
        end
      end
    end

    class Locals
      def initialize(hash)
        @hash = hash
      end

      def method_missing(m)
        raise ArgumentError, "The variable '#{m}' is not available" unless @hash.has_key?(m.to_s)
        @hash[m.to_s]
      end
    end
  end
end