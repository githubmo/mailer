module Blinkbox
  module Mailer
    class Customer < ActionMailer::Base
      layout 'october_launch'

      default :from => "test@example.com",
              :template_path => 'customer'

      def welcome_to_blinkbox_books(variables = {})
        @variables = variables
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
  end
end