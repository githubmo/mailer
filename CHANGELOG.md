#Mailer Change Log

## 1.5.0 ([#36](https://git.mobcastdev.com/Platform/mailer/pull/36) 2014-08-04 10:01:01)

Added skeleton for the hudl2 welcome emails

#### New feature:

Adding support for hudl2 welcome emails

## 1.4.4 ([#37](https://git.mobcastdev.com/Platform/mailer/pull/37) 2014-08-04 10:38:05)

Use artifactory

Patch to use the platform cache on Artifactory

## 1.4.3 ([#35](https://git.mobcastdev.com/Platform/mailer/pull/35) 2014-07-01 13:37:53)

Tests now checking sender display name

#### Patching Tests

Previously the tests were checking the email was from "test@test.com", now it checks the email address and display name e.g. "tester <test@test.com>"

## 1.4.2 ([#34](https://git.mobcastdev.com/Platform/mailer/pull/34) 2014-06-27 10:44:34)

Fixed a test

### Bug fix

- [CP-1545](http://jira.blinkbox.local/jira/browse/CP-1545) - Extracting the email sender from the properties files into the email variables so that they can be used.

## 1.4.1 ([#33](https://git.mobcastdev.com/Platform/mailer/pull/33) 2014-06-27 10:38:27)

Extracting the sender from the properties file into the email_variables

### Bug fix

- [CP-1545](http://jira.blinkbox.local/jira/browse/CP-1545) - Extracting the email sender from the properties files into the email variables so that they can be used.

## 1.4.0 ([#32](https://git.mobcastdev.com/Platform/mailer/pull/32) 2014-06-10 11:22:02)

CWA-1609 Update terms and conditions

#### New Feature

- [CWA-1609] (https://tools.mobcastdev.com/jira/browse/CWA-1609) - Web - LEGAL - Update TCS & conf email

## 1.3.0 ([#31](https://git.mobcastdev.com/Platform/mailer/pull/31) 2014-05-07 12:13:57)

Added support for multiple headers

### New Feature

Added support for multiple headers

* [CP-1380](https://tools.mobcastdev.com/jira/browse/CP-1380)
* [CP-1427](https://tools.mobcastdev.com/jira/browse/CP-1427)

Added support for cc and bcc

## 1.2.0 (2014-04-21 11:34)

### Feature

- [CP-1380](https://tools.mobcastdev.com/jira/browse/CP-1380) - Allow for the specification of the 'x-et-route' header in the emails to be configurable to accomodate the use of ExactTarget.


## 1.1.6 (2014-04-17 16:00)

- [CWA-1410] (https://tools.mobcastdev.com/jira/browse/CWA-1410) - Change link for iTunes

## 1.1.5 (2014-03-14 16:00)

- [CWA-1271] (https://tools.mobcastdev.com/jira/browse/CWA-1271) - Change link is password confirmed email

## 1.1.4 (2014-03-06 15.52)

- [CWA-1144] (https://tools.mobcastdev.com/jira/browse/CWA-1144) - Make sure iOS and Google play URLS are correct

## 1.1.3 (2014-01-28 11:55)

### Bug Fix

- [CWA-1102](https://tools.mobcastdev.com/jira/browse/CWA-1102) - CSS refresh - part 2 - blockers

## 1.1.2 (2014-01-22 16:22)

### Bug Fix

- [CWA-992](https://tools.mobcastdev.com/jira/browse/CWA-992) - CSS refresh

## 1.1.1 (2014-01-22 16:22)

### Bug Fix

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
