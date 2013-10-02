Feature: Sending a receipt after purchasing an item
  As the email message transformation service
  I want to be able to send a confirmation of book purchase made by the user
  So that the user is informed that his purchase was successful

  Scenario: Generating an email from a template and provided variables
    Given a "reciept" email message is pending processing
    And it has the recipients:
      | type | name     | email                           |
      | to   | John Doe | blinkbox_test+johndoe@gmail.com |
    And it has the template variables:
      | salutation | John |
      | bookTitle | Moby Dick |
      | author | Herman Melville |
      | price | 0.17 |
    When the message is processed
    Then I deliver an email to "test@blinkbox.com"
    And it has the subject "Thank you for choosing blinkbox"
    And it matches the output "reciept.output"
    And an email is delivered to "blinkbox_test+jondoe@gmail.com"

