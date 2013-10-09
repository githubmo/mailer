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
