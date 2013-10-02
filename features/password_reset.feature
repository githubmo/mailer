Feature: Sending a password reset email
  As a program that automates email sending
  I want to be able to send a password reset email to a user with the user's variables
  So that the user can receive a personalised templated email asking him to reset

  Scenario: Generating an email from a template and provided variables
    Given I am using the "password reset" template
    When I am given the sender email as "test@blinkbox.com"
    And I am provided the following template variables:
      | salutation | John |
    Then I produce an email to "test@blinkbox.com"
    And it has the subject "Password reset for your Blinkbox Books account"
    And it starts with "Dear John"
    And it contains the text "We have received a request to reset your blinkbox account password."