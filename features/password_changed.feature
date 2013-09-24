Feature: Password Changed confirmation email
As a user
I would like to recieve the confirmation email for when my password has been changed successfully
So that I know the password change was successful and be fully aware whenever a password change in my account has occurred

  Scenario: Change password notification
    Given I have registered an account
    When I change my password
    Then I will receive an email notification that my password has been changed
    And the email contains my name and a link to a page with Help Desk contact information