Feature: Sending a welcome email
  As a program that automates email sending
  I want to be able to send a welcome email to a customer
  So that the customer can receive an appealing confirmation of joining blinkbox books

  Scenario: Generating an email from a template and provided variables
    Given I am using the "welcome to blinkbox books" template
    When I am given the sender email as "test@blinkbox.com"
    And I am provided the following template variables:
      | salutation | John |
    Then I produce an email to "test@blinkbox.com"
    And it has the subject "Welcome to blinkbox books, John"
    And it starts with "Hi, John"
    And it contains the text "Thanks for joining us"