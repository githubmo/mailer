# Mailer

This is a simple ruby application which sits and listens to a message queue for instructions to send particular email templates to the given address.

## Using this app

### Message format

Currently the message format expected is JSON:

    {
      "to": "jphastings@blinkbox.com",
      "template": "welcome_to_blinkbox_books",
      "first_name": "JP"
    }

This will render the email templates `welcome_to_blinkbox_books.text.erb` and `welcome_to_blinkbox_books.html.erb` and will deliver a multipart email to the given email address.

### Writing templates

Templates are named after the delivery methods defined in `models.rb`. Default options are set and the templates at `method_name.text.erb` and `method_name.html.erb` are rendered and delivered.

To access the variables sent in the message in a template you need to use [ERB](http://rrn.dk/rubys-erb-templating-system). Outputing a variable can be done with `<%=@variables.name_of_variable%>`, the `@variables` object will raise an error if the variable you're looking for isn't in the message (and thus prevent the email from being sent), so if you want to prevent this you need to `rescue`:

    Hey there <%=(@variables.first_name rescue 'dude')%>,

### Executing the app

1. Clone this repo
2. Ensure you have all the necessary gems `bundle install --deployment`
3. Copy the `mailer.properties.production` file to `mailer.properties` and edit to suit your set up
4. Execute the app with `foreman start` or by running `bundle exec bin/blinkbox-mailer`
5. Push a message to the `Emails.Outbound` queue!