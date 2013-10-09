require "spec_helper.rb"
require "lib/blinkbox/mailer/xml_parser"

describe Blinkbox::Mailer::XmlParser do
  it "returns the correct hash when given a compliant XML" do
    xml = File.open("spec/support/sample_xml.xml") { |file| file.read }
    hash = Blinkbox::Mailer::XmlParser.get_vars_from_xml(xml)
    expected_hash = { "r:messageId" => "9678170f7c21-47dc-d8f3-a60f-c73e4c58",
                      "template" => "receipt",
                      "to" => [{ "name" => "John Doe", "email" => "john.doe@example.com" }],
                      "cc" =>
                        [
                          { "name" => "John Doe", "email" => "john.doe.alt.mail@example.com" }],
                      "bcc" =>
                        [
                          { "name" => "Email Auditor", "email" => "email.audit@blinkbox.com" }],
                      "templateVariables" =>
                        { "salutation" => "John",
                          "bookTitle" => "Moby Dick",
                          "author" => "Herman Melville",
                          "price" => "0.17" } }
    expect(hash).to eq expected_hash
  end
end