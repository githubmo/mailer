Feature: Sending a welcome email
  As the email message transformation service
  I want to be able to send a welcome email to a customer
  So that the customer can receive an appealing confirmation of joining blinkbox books

  Scenario: Generating an email from a template and provided variables
    Given a "welcome" email message is pending processing
    And it has the recipients:
      | type | name     | email                           |
      | to   | John Doe | blinkbox_test+johndoe@gmail.com |
    And it has the template variables:
      | salutation | John |
    When the message is processed
    Then I deliver an email to "test@blinkbox.com"
    And it has the subject "Welcome to blinkbox books, John"
    And it matches the output "welcome.output"
    And an email is delivered to "blinkbox_test+jondoe@gmail.com"