Feature: Sending a password reset email
  As a program that automates email sending
  I want to be able to send a password reset email to a user with the user's variables
  So that the user can receive a personalised templated email asking him to reset

  Background:
    Given a "password_reset" email message is pending processing
    And it has the recipients:
      | type | name     | email                           |
      | to   | John Doe | blinkbox_test+johndoe@gmail.com |
    And it has the template variables:
      | salutation         | John                                                |
      | resetLink | http://blinkbox.com/example_password_reset_url.html |

  Scenario: Sending a password reset email with link when given the correct template variable
    When the message is processed
    Then an email is delivered to "blinkbox_test+jondoe@gmail.com"
    And it has the subject "Password reset for your blinkbox books account"
    And the html and text component matches the example output "password_reset"

  Scenario Outline: Receipt email generation fails when missing a required variable
    But I do not provide the template variable "<missing_variable>"
    When the message is processed
    Then I do not deliver an email to "blinkbox_test+johndoe@gmail.com"
    And the message is rejected

  Examples:
    | missing_variable   |
    | salutation         |
    | resetLink |