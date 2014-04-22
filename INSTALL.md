#Mailer install instructions

##Requirements:

- ActionMailer
- Bunny
- java_properties gem

##How to install:
1. Clone the repository
2. Copy the `mailer.properties.production` file to `mailer.properties` and edit to suit your set up. If used in production, please fill in with the Mendrill account details.
3. Run the following commands:

```
bundle install --deployment --without development test
bundle exec ruby ./bin/blinkbox-mailer
```

##Note on properties:

The properties file is self evident. The server settings can change at anytime as we may move from Mandrill to ExactTarget or any other mail supplier.

Resource server properties are there for when we want to include offline viewing of the emails in the future. The feature is implemented already.

It is worth noting that the route key is something that should be recieved from the ExactTarget site and would be something that should be obtained from Marketing or access from the ExactTarget site. SMTP settings are dependent on ExatTarget too if we move to them.

Another note, the email_queue should always be `Emails.Outbound`, and should not change even though it is configurable. 
