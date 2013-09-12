module Blinkbox
  module Mailer
    class Customer < ActionMailer::Base
      layout 'october_launch'

      default :from => "blinkbox books <maildev.blinkboxbooks@gmail.com>",
              :template_path => 'customer'

      def welcome_to_blinkbox_books(variables = {})
        @variables = Locals.new(variables)
        mail(
          :to => variables['to'],
          :subject => variables['subject'] || "Welcome to blinkbox books"
        )
      end

      def reset_password(variables = {})
        @variables = variables
        mail(
          :to => variables['to'],
          :subject => variables['subject'] || "Password reset"
        )
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