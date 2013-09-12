require 'action_mailer'

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :file
# ActionMailer::Base.delivery_method = :smtp
# ActionMailer::Base.smtp_settings = {
#    :address   => "smtp.gmail.com",
#    :port      => 587,
#    :domain    => "domain.com.ar",
#    :authentication => :plain,
#    :user_name      => "test@domain.com.ar",
#    :password       => "passw0rd",
#    :enable_starttls_auto => true
#   }
ActionMailer::Base.view_paths = File.join(File.dirname(__FILE__),'..','..','..','templates')