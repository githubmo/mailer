Given(/^a "([^"]*)" email message is pending processing$/) do |template|
  @template = template.gsub(/\s+/, '_')
  @options = {}
  @options[:template.to_s] = @template
end

Given(/^I am not using a template$/) do
  @template = nil
  @options = {}
end

Given(/^it has the recipients:$/) do |table|

  table.hashes.each do |recipient|
    (@options[recipient.delete("type")] ||= []).push recipient
  end
  @options
end

Given(/^it has the template variables:$/) do |table|
  # table example | salutation | John |
  @options['templateVariables'] = {}
  table.raw.each {|k,v| @options['templateVariables'][k] = v}
end

When(/^the sender is set to "([^"]*)"$/) do |sender|
  @options["email_sender"] = sender
end

When(/^I do not provide the template variable "([^"]*)"$/) do |template_variable|
  # The template_variable will either be in the root of the hash or inside the templateVariables sub hash
  @options["templateVariables"].delete template_variable
end

When(/^the message is rejected$/) do
  delivery_id = $nacked.pop
  expect(delivery_id ).to eq @delivery_id
end

When(/^the message is processed$/) do
  ActionMailer::Base.delivery_method = :test
  fake_delivery_options = Bunny::DeliveryInfo.new
  @delivery_id = fake_delivery_options.identifier
  $mailer_daemon.process_mail(fake_delivery_options, @options)
end

Then(/^an email is delivered to "(.*)"$/) do |email_address|
  number_of_emails_delivered = ActionMailer::Base.deliveries.size
  @email = ActionMailer::Base.deliveries.pop rescue nil # We always want to pop between tests
  expect(number_of_emails_delivered).to eq 1
end

Then(/^it has the subject "(.*)"$/) do |subject|
  expect(@email.subject).to eq subject
end

Then(/^the html and text component matches the example output "(.*?)"$/) do |file|
  # test the html part, ignoring any whitespace
  output_example_html_file = File.open("#{$example_outputs_location}/#{file}.example.html") {|file| file.read}
  expected_html = output_example_html_file
  html_body = @email.html_part.body.raw_source
  #expect(html_body).to eq (expected_html)
  expect(Hash.from_xml(html_body)).to eq(Hash.from_xml(expected_html))

  # test the plain text part, ignoring any white space
  output_example_txt_file = File.open("#{$example_outputs_location}/#{file}.example.txt") {|file| file.read}
  expected_txt = output_example_txt_file
  body = @email.text_part.body.raw_source
  expect(body).to eq (expected_txt)
end

Then(/^I do not deliver an email to "(.*)"$/) do |email|
  expect(ActionMailer::Base.deliveries.size).to eq 0
end

Then(/^I get a message sent the "([^"]*)" queue$/) do |queue_suffix|
  deliver_id = $nacked.pop
  expect(deliver_id).to eq @delivery_id
end

When(/^the sender is "([^"]*)"$/) do |sender|
  expect(@email.from[0]).to eq sender
end