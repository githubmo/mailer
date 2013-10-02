Feature: Sending a password reset email
  As a program that automates email sending
  I want to be able to send a password reset email to a user with the user's variables
  So that the user can receive a personalised templated email asking him to reset

  Scenario: Sending a password reset email with link when given the correct template variable
    Given a "password reset" email message is pending processing
    And it has the recipients:
      | type | name     | email                           |
      | to   | John Doe | blinkbox_test+johndoe@gmail.com |
    And it has the template variables:
      | salutation | John |
      | resetLink | https://example.com/reset-john |
    When the message is processed
    Then I deliver an email to "test@blinkbox.com"
    And it has the subject "Password reset for your Blinkbox Books account"
    And it matches the output "password_reset.output"
    And an email is delivered to "blinkbox_test+jondoe@gmail.com


  Scenario Outline: Receipt email generation fails when missing variable
    But I do not provide the variable "<missing_variable>"
    When the message is processed
    Then I do not deliver an email to "blinkbox_test+johndoe@gmail.com"
    And the message is rejected

  Examples:
    | missing_variable      |
    | recipient             |
    | salutation            |
    | resetLink             |