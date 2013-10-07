require "active_support/all"

module Blinkbox
  module Mailer

    class XmlParser

      META_DATA=%w(xmlns xmlns:r r:originator r:instance r:messageId)


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
      #{
      #  "template"=>"receipt",
      #  "to"=>{"recipient"=>{"name"=>"John Doe", "email"=>"john.doe@example.com"}},
      #  "cc"=>
      #  {"recipient"=>
      #     {"name"=>"John Doe", "email"=>"john.doe.alt.mail@example.com"}},
      #  "bcc"=>
      #  {"recipient"=>
      #     {"name"=>"Email Auditor", "email"=>"email.audit@blinkbox.com"}},
      #  "salutation"=>"John",
      #  "bookTitle"=>"Moby Dick",
      #  "author"=>"Herman Melville",
      #  "price"=>"0.17"
      #}
      def self.get_vars_from_xml(xml)
        # Get the hash from the xml and extract away all the extra metadata we don't need.
        hash = Hash.from_xml(xml)
        hash = hash["sendEmail"]
        hash = hash.select {|k,v| !META_DATA.include? k}

        # Extract the template variables from {{key: "h_key", value: "h_value"}} to {{"h_key" => "h_value"}}
        template_variables = hash["templateVariables"]["templateVariable"]
        template_variables.map!{|entry| {entry["key"] => entry["value"]}}

        # Remove templateVariables and add each entry template_variable entry to the hash
        hash.delete "templateVariables"
        template_variables.each do |entry|
          hash.merge! entry
        end

        # Return the final hash
        hash
      end

    end

  end
end
