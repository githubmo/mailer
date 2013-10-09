require "active_support/core_ext/hash/conversions"

# todo: use a deserialiser onto a ruby object.
module Blinkbox
  module Mailer

    class XmlParser

      META_DATA=%w(^xmlns$ ^xmlns: :originator$ :instance$).map {|w| Regexp.new(w)}

      # Given an XML that complies with out schema, found at the below url:
      #   url => https://tools.mobcastdev.com/confluence/display/PT/Mailer+-+Email+templating+and+sending
      # We produce a hash that can be used for our mailer program.
      #
      # Specifically, this is a method for transforming the following XML structure
      #<sendEmail
      #    xmlns="http://schemas.blinkbox.com/books/emails/sending/v1"
      #    xmlns:r="http://schemas.blinkbox.com/books/routing/v1"
      #    r:originator="bookStore"
      #    r:instance="book-store.mobcast.co.uk"
      #    r:messageId="9678170f7c21-47dc-d8f3-a60f-c73e4c58">
      #
      #    <template>receipt</template>
      #
      #<to>
      #  <!-- must contain at least one recipient element -->
      #  <recipient>
      #    <name>John Doe</name>
      #    <email>john.doe@example.com</email>
      #  </recipient>
      #    </to>
      #
      #<!-- cc and bcc are optional -->
      #<cc>
      #  <!-- must contain at least one recipient element -->
      #  <recipient>
      #    <name>John Doe</name>
      #    <email>john.doe.alt.mail@example.com</email>
      #  </recipient>
      #    </cc>
      #<bcc>
      #  <!-- must contain at least one recipient element -->
      #  <recipient>
      #    <name>Email Auditor</name>
      #    <email>email.audit@blinkbox.com</email>
      #  </recipient>
      #    </bcc>
      #
      #<templateVariables>
      #  <templateVariable>
      #    <key>salutation</key>
      #    <value>John</value>
      #  </templateVariable>
      #
      #    <templateVariable>
      #    <key>bookTitle</key>
      #    <value>Moby Dick</value>
      #    </templateVariable>
      #
      #  <templateVariable>
      #    <key>author</key>
      #    <value>Herman Melville</value>
      #  </templateVariable>
      #
      #    <templateVariable>
      #    <key>price</key>
      #    <value>0.17</value>
      #    </templateVariable>
      #</templateVariables>
      #
      #    </sendEmail>
      #
      # Into the following hash:
      #
      #{ "template" => "receipt",
      #  "to" => [{ "name" => "John Doe", "email" => "john.doe@example.com" }],
      #  "cc" =>
      #    [
      #      { "name" => "John Doe", "email" => "john.doe.alt.mail@example.com" }],
      #  "bcc" =>
      #    [
      #      { "name" => "Email Auditor", "email" => "email.audit@blinkbox.com" }],
      #  "templateVariables" =>
      #    { "salutation" => "John",
      #      "bookTitle" => "Moby Dick",
      #      "author" => "Herman Melville",
      #      "price" => "0.17" } }
      #
      # PLEASE NOTE: The template variables are in camel case instead of snake case as that is the convention for XML
      # and the decision was made to preserve the name as it appears in the XML
      def self.get_vars_from_xml(xml)
        # Get the hash from the xml and extract away all the extra metadata we don't need.
        hash = Hash.from_xml(xml)
        hash = hash["sendEmail"]
        hash = hash.select {|k,v| META_DATA.select{ |regexp| regexp.match(k)}.empty? }

        %w{to cc bcc}.each do |send_verb|
          array = []
          hash[send_verb].each_value do |recipeint|
            array << recipeint
          end if hash[send_verb]
          hash[send_verb] = array
        end

        # Extract the template variables from {{key: "h_key", value: "h_value"}} to {{"h_key" => "h_value"}}
        template_variables = hash["templateVariables"]["templateVariable"]
        template_variables.map!{|entry| {entry["key"] => entry["value"]}}

        # Remove templateVariables and add each entry template_variable entry to the hash
        hash.delete "templateVariables"
        hash["templateVariables"] = {}
        template_variables.each do |entry|
          hash["templateVariables"].merge! entry
        end

        # Return the final hash
        hash
      end

    end

  end
end
