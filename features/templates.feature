Feature: Sending a welcome email
As a program that automates email sending
I want to be able to send a welcome email to a customer
So that the customer can receive an appealing confirmation of joining blinkbox books

  Scenario: Generating an email from a template and provided variables
    Given I am using the "welcome to blinkbox books" template
    When I provide the following variables:
      | email | test@blinkbox.com |
      | first name | John |
    Then I produce an email to "test@blinkbox.com"
    And it has the subject "Welcome to blinkbox books, John"
    And it starts with "Hi, John"
    And it contains the text "Thanks for joining us"

  Feature: Sending a password reset email
  As a program that automates email sending
  I want to be able to send a password reset email to a user with the user's variables
  So that the user can receive a personalised templated email asking him to reset

  Scenario: Generating an email from a template and provided variables
    Given I am using the "password reset" template
    When I provide the following variables:
      | email | test@blinkbox.com |
      | first name | John |
    Then I produce an email to "test@blinkbox.com"
    And it has the subject "Password reset for your Blinkbox Books account"
    And it starts with "Dear John"
    And it contains the text "We have received a request to reset your blinkbox account password."

  Feature: Sending a password changed
  As a program that automates email sending
  I want to be able to send a confirmation of a password change to a user
  So that the user is informed that his password change was successful

  Scenario: Generating an email from a template and provided variables
    Given I am using the "password change" template
    When I provide the following variables:
      | email | test@blinkbox.com |
      | first name | John |
    Then I produce an email to "test@blinkbox.com"
    And it has the subject "Password change confirmation"
    And it starts with "Dear John"
    And it contains the text "Your password for blinkbox books has successfully been changed."

  Feature: Sending a receipt after purchasing an item
  As a program that automates email sending
  I want to be able to send a confirmation of book purchase made by the user
  So that the user is informed that his purchase was successful

  Scenario: Generating an email from a template and provided variables
    Given I am using the "password change" template
    When I provide the following variables:
      | email | test@blinkbox.com |
      | first name | John |
      | title name| Moby Dick |
      | auther name | Herman Melville |
      | price | 0.17 |
    Then I produce an email to "test@blinkbox.com"
    And it has the subject "Thank you for choosing blinkbox"
    And it starts with "Hi, John"
    And it contains the text "Thanks for choosing to use blinkbox books."
    And it contains the text "Moby Dick"
    And it contains the text "Herman Melville"
    And it contains the text "You paid: £0.17"