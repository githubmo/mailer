Feature: A service which will watch a queue for emails needing to be sent and deliver them by SMTP.
  As an e-commerce website
  I want to send emails to my customers
  So that I can communicate important information

  @manual
  Scenario: Timely sending of emails
    When I request an email to be sent
    Then I expect that email to be sent within 60 seconds 99% of the time

  @in_proc
  Scenario: Logging an error if required template variables are not present
    Given I am not using a template
    And it has the recipients:
      | type | name     | email                           |
      | to   | John Doe | blinkbox_test+johndoe@gmail.com |
    When the message is processed
    Then I do not deliver an email to "blinkbox_test+johndoe@gmail.com"
    And I get a message sent the "DLQ" queue