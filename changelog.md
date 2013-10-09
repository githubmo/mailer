#Mailer Changelog

### 2013-10-09 15:48
- An end to end mailing working including:
  - Listening on the Email.Outgoing queue
  - Transferring XML given to us from RabbitMQ into Hash
  - Creating HTML and TXT from variables and templates
  - Creating a multipart email from the HTML and TXT that were created.
  - Sending the email if everything is valid.
  - Sending back to the DLQ if a variable is provided or the email was not sent out.