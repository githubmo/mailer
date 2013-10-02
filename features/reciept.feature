Feature: Sending a receipt after purchasing an item
  As a program that automates email sending
  I want to be able to send a confirmation of book purchase made by the user
  So that the user is informed that his purchase was successful

  Scenario: Generating an email from a template and provided variables
    Given I am using the "password change" template
    When I am given the sender email as "test@blinkbox.com"
    And I am provided the following template variables:
      | salutation | John |
      | bookTitle | Moby Dick |
      | author | Herman Melville |
      | price | 0.17 |
    Then I produce an email to "test@blinkbox.com"
    And it has the subject "Thank you for choosing blinkbox"
    And it starts with "Hi, John"
    And it contains the text "Thanks for choosing to use blinkbox books."
    And it contains the text "Moby Dick"
    And it contains the text "Herman Melville"
    And it contains the text "You paid: £0.17"