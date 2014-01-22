def hash_from_html(html)
  hash = Hash.from_xml(html)
  hash["html"]["head"]["style"].gsub!(/\s+/, "")
  hash
end