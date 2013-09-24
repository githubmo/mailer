Feature: Password Resets
As a user who has forgotten his password
I want to retrieve the email with the link to reset my password
So that I am able to reset it and get back to using blinkbox books service

  Background:
    Given I have forgotten my password

  Scenario: Request a password reset
    When I request a password reset for a registered email address
    Then I will receive an email containing my name, a link to the customer care site and a link to reset my password

  Scenario: Request a password reset for a non-existent email address
    When I request a password reset for an email address for which no account is registered
    Then no email is sent
    And no feedback is given to me indicating the email address was not registered