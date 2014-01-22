#Mailer Change Log

## 0.14.1 (2014-01-22 16:22)

### Changed footer links

- [CWA-992](https://tools.mobcastdev.com/jira/browse/CWA-992) - CSS refresh

## 1.1.0 (2014-01-22 12:10)

### CSS refresh

- [CWA-992](https://tools.mobcastdev.com/jira/browse/CWA-992) - CSS refresh

## 1.0.7 (2014-01-13 11:18)

### Bug fix

- [CP-963](https://tools.mobcastdev.com/jira/browse/CP-963) - Reporting support for user and client events.

## 1.0.6 (2013-12-06 16:10)

- [CP-808](https://tools.mobcastdev.com/jira/browse/CP-808) - Fix for not copign with a rabbitmq restart.
- [CP-811](https://tools.mobcastdev.com/jira/browse/CP-811) - Updated HTML to the latest round of template update from UX

## 1.0.5 (2013-11-06 14:10)

- Changed the footer of the email templates to reflect the new address.

## 1.0.4 (2013-11-04 11:56)

### Enhancements

- Better templates based on feedback from UI


## 1.0.3 (2013-10-23 11:35)

### Bug Fix

- Removing line breaks that causes issues in Outlook 2013

## 1.0.2 (2013-10-15 17:49)

### Bug Fixes
- [CP-657](https://tools.mobcastdev.com/jira/browse/CP-657) Link clicks are not tracked on password reset emails.
- The 'from' email address now uses the _blinkboxbooks.com_ domain, rather than _blinkbox.com_.

## 1.0.1 (2013-10-11 17:29)

### Bug Fixes
- Fixed a bug for when receiving an XML with just one template variable, it is not processed correctly.

### Features
- An end to end mailing working including:
  - Listening on the Email.Outgoing queue
  - Transferring XML given to us from RabbitMQ into Hash
  - Creating HTML and TXT from variables and templates
  - Creating a multipart email from the HTML and TXT that were created.
  - Sending the email if everything is valid.
  - Sending back to the DLQ if a variable is provided or the email was not sent out.

## 1.0.0 (2013-10-09 15:48)

### Features
- An end to end mailing working including:
  - Listening on the Email.Outgoing queue
  - Transferring XML given to us from RabbitMQ into Hash
  - Creating HTML and TXT from variables and templates
  - Creating a multipart email from the HTML and TXT that were created.
  - Sending the email if everything is valid.
  - Sending back to the DLQ if a variable is provided or the email was not sent out.
