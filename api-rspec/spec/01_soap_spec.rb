load File.dirname(__FILE__) + "/../test_helper.rb"

require "net/http"
require "net/https"
require "erb"
require "tilt"
require "httparty"

describe "SOAP Testing" do
  include TestHelper

  before(:all) do
  end

  after(:all) do
  end

  # A list of free web services,  http://www.service-repository.com/
  it "SOAP 1.1 with sample XML" do

    # http://www.w3schools.com/xml/tempconvert.asmx?WSDL

    #POST http://www.w3schools.com/xml/tempconvert.asmx HTTP/1.1
    #Accept-Encoding: gzip,deflate
    #Content-Type: text/xml;charset=UTF-8
    #SOAPAction: "http://www.w3schools.com/webservices/CelsiusToFahrenheit"
    #Content-Length: 342
    #Host: www.w3schools.com
    #Connection: Keep-Alive
    #User-Agent: Apache-HttpClient/4.1.1 (java 1.5)

    request_xml = <<END_OF_MESSAGE
<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <CelsiusToFahrenheit xmlns="https://www.w3schools.com/xml/">
      <Celsius>10</Celsius>
    </CelsiusToFahrenheit>
  </soap:Body>
</soap:Envelope>
END_OF_MESSAGE

    # http = Net::HTTP.new('www.w3schools.com', 443)
    uri = URI.parse("https://www.w3schools.com/xml/tempconvert.asmx")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    resp, data = http.post(uri.path, request_xml,
                           {
      "SOAPAction" => "https://www.w3schools.com/xml/CelsiusToFahrenheit",
      "Content-Type" => "text/xml",
      "Host" => "www.w3schools.com",
    })
    puts resp.body
    expect(resp.code).to eq("200") # OK
    # debug resp.body
    # resp.each { |key, val| debug(key + ' = ' + val) }
    expect(resp.body).to include("<CelsiusToFahrenheitResult>50</CelsiusToFahrenheitResult>")
  end

  #   <?xml version="1.0" encoding="utf-8"?>
  #  Unexpected XML declaration. The XML declaration must be the first node in the document, and no white space characters are allowed to appear before it.
  it "SOAP 1.2 with sample XML" do
    request_xml = <<END_OF_MESSAGE
<?xml version="1.0" encoding="utf-8"?>
<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
  <soap12:Body>
    <CelsiusToFahrenheit xmlns="https://www.w3schools.com/xml/">
      <Celsius>20</Celsius>
    </CelsiusToFahrenheit>
  </soap12:Body>
</soap12:Envelope>
END_OF_MESSAGE

    # http = Net::HTTP.new('www.w3schools.com', 443)
    uri = URI.parse("https://www.w3schools.com/xml/tempconvert.asmx")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    resp, data = http.post(uri.path, request_xml,
                           { "SOAPAction": "https://www.w3schools.com/xml/CelsiusToFahrenheit",
                             "Content-Type": "text/xml",
                             "Host": "www.w3schools.com" })
    puts resp.body
    expect(resp.code).to eq("200") # OK
    # debug resp.body
    # resp.each { |key, val| debug(key + ' = ' + val) }
    expect(resp.body).to include("<CelsiusToFahrenheitResult>68</CelsiusToFahrenheitResult>")
  end

  it "SOAP with dynamic request data" do
    template_erb_file = File.expand_path("../../testdata/c_to_f.xml.erb", __FILE__)
    template_erb_str = File.read(template_erb_file)
    @degree = 30 # changeable in your test script
    request_xml = ERB.new(template_erb_str).result(binding)

    uri = URI.parse("https://www.w3schools.com/xml/tempconvert.asmx")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    resp, data = http.post(uri.path, request_xml, {
      "SOAPAction" => "https://www.w3schools.com/xml/CelsiusToFahrenheit",
      "Content-Type" => "text/xml",
      "Host" => "www.w3schools.com",
    })
    expect(resp.code).to eq("200") # OK
    puts resp.body
    expect(resp.body).to include("<CelsiusToFahrenheitResult>86</CelsiusToFahrenheitResult>")
  end

  it "Post with HTTParty" do
    template_erb_file = File.expand_path("../../testdata/c_to_f.xml.erb", __FILE__)
    template_erb_str = File.read(template_erb_file)
    @degree = 30 # changeable in your test script
    request_xml = ERB.new(template_erb_str).result(binding)
    resp = HTTParty.post("https://www.w3schools.com/xml/tempconvert.asmx", 
      :body => request_xml,
      :headers => {
        "SOAPAction" => "https://www.w3schools.com/xml/CelsiusToFahrenheit",
        "Content-Type" => "text/xml",
        "Host" => "www.w3schools.com",
       })
    expect(resp.code).to eq(200) # OK
    puts resp.body
    expect(resp.body).to include("<CelsiusToFahrenheitResult>86</CelsiusToFahrenheitResult>")
  end

  it "Parse XML after stripping namespace" do
    xml = '<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><CelsiusToFahrenheitResponse xmlns="https://www.w3schools.com/xml/"><CelsiusToFahrenheitResult>86</CelsiusToFahrenheitResult></CelsiusToFahrenheitResponse></soap:Body></soap:Envelope>'
    require "nokogiri"
    xml_doc = Nokogiri.parse(xml)
    xml_doc.remove_namespaces!

    # debug xml_doc.to_s #
    node = "//CelsiusToFahrenheitResponse/CelsiusToFahrenheitResult"
    expect(xml_doc.xpath(node).text).to eq("86")
  end

end
