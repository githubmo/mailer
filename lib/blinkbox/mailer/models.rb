module Blinkbox
  module Mailer
    class Customer < ActionMailer::Base
      layout 'october_launch'

      default from: "blinkbox books <maildev.blinkboxbooks@gmail.com>"

      def welcome(variables = {})
        @variables = Locals.new(variables["templateVariables"])
        mail(
          to: variables['to'][0]['email'],
          subject: variables['subject'] || "Welcome to blinkbox books"
        ) do |format|
          format.html
          format.text
        end
      end

      def receipt(variables = {})
        @variables = Locals.new(variables["templateVariables"])
        mail(
          to: variables['to'][0]['email'],
          subject: variables['subject'] || "Thank you for choosing blinkbox."
        ) do |format|
          format.html
          format.text
        end
      end

      def password_confirmed(variables = {})
        @variables = Locals.new(variables["templateVariables"])
        mail(
          to: variables['to'][0]['email'],
          subject: variables['subject'] || "Password change confirmation for your blinkbox books account."
        ) do |format|
          format.html
          format.text
        end
      end

      def password_reset(variables = {})
        @variables = Locals.new(variables["templateVariables"])
        mail(
          to: variables['to'][0]['email'],
          subject: variables['subject'] || "Password reset for your blinkbox books account"
        ) do |format|
          format.html
          format.text
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