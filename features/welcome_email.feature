Feature: Sending welcome emails
As a user of blinkbox books
I want to be able to retrieve welcome emails when I sign up
So that I know that my sign in attempt with the credentials provided was successful

  Scenario: registered with blinkbox books notification
    Given I am not registered with blinkbox books
    When I register with blinkbox books
    Then I should receive an email notification
    And the email should be addressed to the email address I registered with
    And  the email should include my first name.