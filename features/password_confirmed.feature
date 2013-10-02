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
    Then I deliver an email to "blinkbox_test+jondoe@gmail.com"
    And it has the subject "Password change confirmation"
    And the html component matches the output "password_change.output"


  Scenario Outline: Receipt email generation fails when missing variable
    But I do not provide the variable "<missing_variable>"
    When the message is processed
    Then I do not deliver an email to "blinkbox_test+johndoe@gmail.com"
    And the message is rejected

    Examples:
      | missing_variable      |
      | recipient             |
      | salutation            |