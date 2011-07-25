
def test_xhtml_included_in_document
  page_text = IO.read("www.w3.org.html")
  document = Document.new(page_text)
  topics = XPath.match(document, '//li/a/abbr')
  assert(topics.find {|topic| topic.text.strip == "XML"})
end
