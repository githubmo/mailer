require 'action_mailer'

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address   => "smtp.gmail.com",
  :port      => 587,
  :domain    => "blinkboxbooks.com",
  :authentication => :plain,
  :user_name      => "maildev.blinkboxbooks@gmail.com",
  :password       => "M0bc45TM0bc45T",
  :enable_starttls_auto => true
}
ActionMailer::Base.view_paths = File.join(File.dirname(__FILE__),'..','..','..','templates')