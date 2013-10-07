require 'action_mailer/test_helper'

# A class for using to stub the action mailer and allow us to test emails being sent
#class MailerTester < ActionMailer::TestCase
#  tests Blinkbox::Mailer::Customer
#
#  test "mailer_tester" do
#    fake_delivery_options = Bunny::DeliveryInfo.new
#    $mailer_daemon.process_mail(fake_delivery_options, @options)
#  end
#end