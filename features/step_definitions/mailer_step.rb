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

Given(/^the sender is set to "([^"]*)"$/) do |sender|
  @options[:email_sender] = sender
end

Given(/^the ExactTarget header is set$/) do
  @et_header = "something-very-long"
  @options[:et_route_key] = @et_header
end

Given(/^the message id header is set$/) do
  @message_id = "message_id"
  @options[:messageId] = @message_id
end

When(/^I do not provide the template variable "([^"]*)"$/) do |template_variable|
  # The template_variable will either be in the root of the hash or inside the templateVariables sub hash
  @options["templateVariables"].delete template_variable
end

When(/^the message is rejected$/) do
  delivery_id = $rejected.pop
  expect(delivery_id ).to eq @delivery_id
end

When(/^the message is processed$/) do
  ActionMailer::Base.delivery_method = :test
  fake_delivery_options = Bunny::DeliveryInfo.new
  @delivery_id = fake_delivery_options.identifier
  begin
    $mailer_daemon.process_message(fake_delivery_options, @options)
  rescue Exception => e
    @process_failure_exception = e
  end
end

Then(/^an email is delivered to "(.*)"$/) do |email_address|
  number_of_emails_delivered = ActionMailer::Base.deliveries.size
  @email = ActionMailer::Base.deliveries.pop rescue nil # We always want to pop between tests
  expect(@email.to[0]).to eq email_address
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
  expect(hash_from_html(html_body)).to eq(hash_from_html(expected_html))

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
  deliver_id = $rejected.pop
  expect(deliver_id).to eq @delivery_id
end

Then(/^the sender is "([^"]*)"$/) do |sender|
  expect(@email.header["from"].value).to eq sender
end

Then(/^it has the exact target headers$/) do
  expect(@email.header["x-et-route"].to_s).to eq(@et_header)
end

Then(/^it has the message id header$/) do
  expect(@email.header["X-BBB-Message-Id"].to_s).to eq(@message_id)
end