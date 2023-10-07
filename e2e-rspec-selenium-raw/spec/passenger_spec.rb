load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Passenger" do
  include TestHelper

  before(:all) do
    # by setting $driver global variable for build_rspec_formatter can save screenshot if error occurs
    @driver = $driver = Selenium::WebDriver.for(browser_type, browser_options)
    driver.manage().window().resize_to(1280, 720)
    driver.manage().window().move_to(30, 78)
    driver.get(site_url)

    driver.find_element(:id, "username").send_keys("agileway")
    driver.find_element(:id, "password").send_keys("testwise")
    driver.find_element(:name, "commit").click

    driver.find_element(:xpath, "//input[@name='tripType' and @value='oneway']").click
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "fromPort")).select_by(:text, "Sydney")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "toPort")).select_by(:text, "New York")

    Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "departDay")).select_by(:text, "02")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "departMonth")).select_by(:text, "May 2023")
    driver.find_element(:xpath, "//input[@value='Continue']").click
  end

  after(:all) do
    driver.quit unless debugging?
  end

  it "[4] Can enter passenger details (using page objects)" do
    
    driver.find_element(:name, "passengerLastName").submit
    expect(page_text).to include("Must provide last name")
  
    driver.find_element(:name, "passengerFirstName").send_keys("Bob")
    driver.find_element(:name, "passengerLastName").send_keys("Tester")
    driver.find_element(:name, "passengerLastName").submit
    sleep 0.5
    
    # the step below fails: "Wendy" => "Bob"
    expect(driver.find_element(:name, "holder_name").attribute("value")).to eq("Bob Tester")
  end
end
