Given(/^a "([^"]*)" email message is pending processing$/) do |template|
  @template = template
  @options = {}
  @options[:template.to_s] = @template
end

When(/^I do not provide the variable "([^"]*)"$/) do |template_variable|
  @options.delete template_variable
end

When(/^it has the recipients:$/) do |table|
  # table is a | to   | John Doe | blinkbox_test+johndoe@gmail.com |
  to = {"recipient" => {}}
  to["recipient"][:name.to_s] = table.hashes[0][:name.to_s]
  to["recipient"][:email.to_s] = table.hashes[0][:email.to_s]
  @options[:to.to_s] = to
end
When(/^it has the template variables:$/) do |table|
  # table example | salutation | John |
  table.raw.each {|k,v| @options[k] = v}
end

When(/^the message is processed$/) do
  ActionMailer::Base.delivery_method = :test
  fake_delivery_options = Bunny::DeliveryInfo.new
  @delivery_id = fake_delivery_options.identifier
  $mailer_daemon.process_mail(fake_delivery_options, @options)
end

Then(/^an email is delivered to "(.*)"$/) do |email_address|
  expect(ActionMailer::Base.deliveries.size == 1)
  @email = ActionMailer::Base.deliveries.pop
end

Then(/^it has the subject "(.*)"$/) do |subject|
  expect(@email.subject).to eq subject
end

Then(/^the html component matches the example output "(.*?)"$/) do |file|
  # test the html part, ignoring any whitespace
  output_example_html_file = File.open("#{$example_outputs_location}/#{file}.example.html") {|file| file.read}
  expected_html = output_example_html_file.gsub(/\s+/, "")
  html_body = @email.html_part.body.raw_source.gsub(/\s+/, "")
  expect(html_body).to eq (expected_html)

  # test the plain text part, ignoring any white space
  output_example_txt_file = File.open("#{$example_outputs_location}/#{file}.example.txt") {|file| file.read}
  expected_txt = output_example_txt_file.gsub(/\s+/, "")
  body = @email.body.parts[0].body.raw_source.gsub(/\s+/, "")
  expect(body).to eq (expected_txt)
end

Then(/^I do not deliver an email to "(.*)"$/) do |email|
  expect(ActionMailer::Base.deliveries.size == 0)
end

When(/^the message is rejected$/) do
  delivery_id = $nacked.pop
  expect(delivery_id ).to eq @delivery_id
end