Feature: A service which will watch a queue for emails needing to be sent and deliver them by SMTP.
As an e-commerce website
I want to send emails to my customers
So that I can communicate important information


  Scenario: Timely sending of emails
    When I request an email to be sent
    Then I expect that email to be sent within 60 seconds 99% of the time