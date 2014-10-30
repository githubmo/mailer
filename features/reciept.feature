Feature: Sending a receipt after purchasing an item
  As the email message transformation service
  I want to be able to send a confirmation of book purchase made by the user
  So that the user is informed that his purchase was successful

  Background:
    Given a "receipt" email message is pending processing
    And it has the recipients:
      | type | name     | email                           |
      | to   | John Doe | blinkbox_test+johndoe@gmail.com |
    And it has the template variables:
      | salutation | John            |
      | bookTitle  | Moby Dick       |
      | author     | Herman Melville |
      | price      | 0.17            |
    And the sender is set to "tester <test@test.com>"
    And the ExactTarget header is set
    And the message id header is set

  Scenario: Generating an email from a template and provided variables
    When the message is processed
    Then an email is delivered to "blinkbox_test+johndoe@gmail.com"
    And it has the subject "Thanks for your purchase from blinkbox Books!"
    And the html and text component matches the example output "receipt"
    And it has the exact target headers
    And the sender is "tester <test@test.com>"
    And it has the message id header

  Scenario Outline: Receipt email generation fails when missing a required variable
    But I do not provide the template variable "<missing_variable>"
    When the message is processed
    Then I do not deliver an email to "blinkbox_test+johndoe@gmail.com"
    And the message is rejected

    Examples:
      | missing_variable      |
      | salutation            |
      | bookTitle             |
      | author                |
      | price                 |

