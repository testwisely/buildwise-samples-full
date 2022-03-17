load File.dirname(__FILE__) + '/../test_helper.rb'

require 'net/http'
require 'net/https'
require 'httpclient'
require 'rexml/document'
require 'nokogiri'

# http://sqlrest.sourceforge.net/5-minutes-guide.htm

describe "REST WebService" do
  include TestHelper


  it "REST - List all records" do
    http = HTTPClient.new
    list_rest_url = "http://www.thomas-bayer.com/sqlrest/CUSTOMER"
    resp = http.get(list_rest_url)
    puts resp.body
    File.open("C:/temp/rest.xml", "w").puts(resp.body) if RUBY_PLATFORM =~ /mingw/
    xml_doc  = REXML::Document.new(resp.body)
    expect(xml_doc.root.elements.size).to be > 10    
  end

  it "REST - Get a record" do
    http = HTTPClient.new
    customer_id = 4
    get_rest_url = "http://www.thomas-bayer.com/sqlrest/CUSTOMER/#{customer_id}"    
    resp = http.get(get_rest_url)
    puts resp.body
    expect(resp.body).to include("<CITY>Dallas</CITY>")
  end

  it "REST - Create a new record" do
    http = HTTPClient.new
    create_rest_url = "http://www.thomas-bayer.com/sqlrest/CUSTOMER/"    
    new_record_xml  = <<END_OF_MESSAGE
<CUSTOMER>
   <ID>6666</ID>
   <FIRSTNAME>Test</FIRSTNAME>
   <LASTNAME>Wise</LASTNAME>
   <STREET>10 Ruby Street</STREET>
   <CITY>Brisbane</CITY>
</CUSTOMER>
END_OF_MESSAGE

    resp  = http.put(create_rest_url, new_record_xml)  
    puts resp.body   # this server returns error buty actually created OK 
  end
  
  it "REST-Client" do
    gem "rest-client"
    require 'rest-client'
    response = RestClient.get "http://www.thomas-bayer.com/sqlrest/CUSTOMER"
    puts response.code
    expect(response.code).to eq(200)
    puts response.headers # {:server=>"Apache-Coyote/1.1", :content_type=>"application/xml", :date=>"Mon, 28 Dec 2015 01:21:18 GMT", :content_length=>"4574"}
    puts response.body  # XML
    
    new_record_xml  = <<END_OF_MESSAGE
<CUSTOMER>
   <ID>7777</ID>
   <FIRSTNAME>Clinic</FIRSTNAME>
   <LASTNAME>Wise</LASTNAME>
   <STREET>20 Ruby Street</STREET>
   <CITY>Brisbane</CITY>
</CUSTOMER>
END_OF_MESSAGE

    begin
      response = RestClient.put "http://www.thomas-bayer.com/sqlrest/CUSTOMER", new_record_xml
      puts response.body
    rescue => e
       puts e
    end
  end
  
  it "Rest-Client: Get and Update" do
    require 'rest-client'
    require 'faker'
    response = RestClient.get "http://www.thomas-bayer.com/sqlrest/CUSTOMER/2"
    expect(response).to include("<ID>2</ID>")
    
    new_city = Faker::Address.city # randomly generated
    response = RestClient.post "http://www.thomas-bayer.com/sqlrest/CUSTOMER/2", "<CUSTOMER><CITY>#{new_city}</CITY></CUSTOMER>"  
    expect(RestClient.get "http://www.thomas-bayer.com/sqlrest/CUSTOMER/2").to include(new_city)
  end

  it "Post JSON" do
    require 'rest-client'
    require 'json' # gem install json

    # using the Get request to get sample JSON
    # ws_url = "http://jsonplaceholder.typicode.com/posts/1"
    # response = RestClient.get(ws_url)    
    new_id = 101
    new_title = "Foo"
    json_request = <<END_OF_MESSAGE
{
  "userId": 1,
  "id":  #{new_id},
  "title": "#{new_title}",
  "body": "some data"
}
END_OF_MESSAGE
    
    puts json_request
    ws_url = "http://jsonplaceholder.typicode.com/posts"
    response = RestClient.post(ws_url, json_request)          
    # puts "=>|#{response.body}|" 
    expect(response.body).to include("#{new_id}")
    
    # use HTTP PUT or Patch to update an existing resource
    json_request.gsub!("101", "10")
    response = RestClient.put(ws_url + "/10", json_request)       
  end
    
end
