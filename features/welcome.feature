Feature: Sending a welcome email
  As the email message transformation service
  I want to be able to send a welcome email to a customer
  So that the customer can receive an appealing confirmation of joining blinkbox books

  Background:
    Given a "welcome" email message is pending processing
    And it has the recipients:
      | type | name     | email                           |
      | to   | John Doe | blinkbox_test+johndoe@gmail.com |
    And it has the template variables:
      | salutation | John |
    And the sender is set to "tester <test@test.com>"

  Scenario: Generating an email from a template and provided variables
    When the message is processed
    Then an email is delivered to "blinkbox_test+jondoe@gmail.com"
    And it has the subject "Welcome to blinkbox books"
    And the html and text component matches the example output "welcome"
    And it has the exact target headers
    And the sender is "test@test.com"

  Scenario Outline: Receipt email generation fails when missing a required variable
    But I do not provide the template variable "<missing_variable>"
    When the message is processed
    Then I do not deliver an email to "blinkbox_test+johndoe@gmail.com"
    And the message is rejected

    Examples:
      | missing_variable      |
      | salutation            |
