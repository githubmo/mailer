Feature: Sending a password changed
  As a program that automates email sending
  I want to be able to send a confirmation of a password change to a user
  So that the user is informed that his password change was successful

  Scenario: Generating an email from a template and provided variables
    Given I am using the "password change" template
    When I am given the sender email as "test@blinkbox.com"
    And I am provided the following template variables:
      | salutation | John |
    Then I produce an email to "test@blinkbox.com"
    And it has the subject "Password change confirmation"
    And it starts with "Dear John"
    And it contains the text "Your password for blinkbox books has successfully been changed."