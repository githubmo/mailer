Feature: Sending a password confirmed email
  As the email message transformation service
  I want the password change which has occurred to be announced to the affected user by email
  So that the user is informed that his password change was successful

  Background:
    Given a "password change" email message is pending processing
    And it has the recipients:
      | type | name     | email                           |
      | to   | John Doe | blinkbox_test+johndoe@gmail.com |
    And it has the template variables:
      | salutation         | John                                                |

  @wip
  Scenario: Sending a password confirmed email when given correct template variables
  # Please note that the names are not homogeneous as the template is called "password change(d)?" from UX
    When the message is processed
    Then an email is delivered to "blinkbox_test+jondoe@gmail.com"
    And it has the subject "Password change confirmation for your blinkbox books account."
    And the html component matches the example output "password_change.example.html"

  Scenario Outline: Receipt email generation fails when missing variable
    But I do not provide the variable "<missing_variable>"
    When the message is processed
    Then I do not deliver an email to "blinkbox_test+johndoe@gmail.com"
    And the message is rejected

    Examples:
      | missing_variable |
      | recipient        |
      | salutation       |