require 'action_mailer'

ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.view_paths = File.join(File.dirname(__FILE__),'..','..','..','templates')