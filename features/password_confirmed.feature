Feature: Sending a password confirmed email
  As the email message transformation service
  I want the password change which has occurred to be announced to the affected user by email
  So that the user is informed that his password change was successful

  Background:
    Given a "password confirmed" email message is pending processing
    And it has the recipients:
      | type | name     | email                           |
      | to   | John Doe | blinkbox_test+johndoe@gmail.com |
    And it has the template variables:
      | salutation         | John                         |
    And the sender is set to "tester <test@test.com>"
    And the ExactTarget header is set
    And the message id header is set

  Scenario: Sending a password confirmed email when given correct template variables
  # Please note that the names are not homogeneous as the template is called "password change(d)?" from UX
    When the message is processed
    Then an email is delivered to "blinkbox_test+johndoe@gmail.com"
    And it has the subject "Your password has been changed"
    And it has the exact target headers
    And the html and text component matches the example output "password_confirmed"
    And the sender is "tester <test@test.com>"
    And it has the message id header

  Scenario Outline: Receipt email generation fails when missing a required variable
    But I do not provide the template variable "<missing_variable>"
    When the message is processed
    Then I do not deliver an email to "blinkbox_test+johndoe@gmail.com"
    And the message is rejected

    Examples:
      | missing_variable |
      | salutation       |