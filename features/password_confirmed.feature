Feature: Sending a password changed email
  As the email message transformation service
  I want the password change which has occurred to be announced to the affected user by email
  So that the user is informed that his password change was successful

  Scenario: Sending a password changed email when given correct template variables
    Given a "password change" email message is pending processing
    And it has the recipients:
      | type | name     | email                           |
      | to   | John Doe | blinkbox_test+johndoe@gmail.com |
    And it has the template variables:
      | salutation | John |
    When the message is processed
    Then I deliver an email to "test@blinkbox.com"
    And it has the subject "Password change confirmation"
    And it matches the output "password_change.output"
    And an email is delivered to "blinkbox_test+jondoe@gmail.com"