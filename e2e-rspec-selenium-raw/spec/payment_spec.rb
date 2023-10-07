load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Payment" do
  include TestHelper

  before(:all) do
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

    driver.find_element(:name, "passengerFirstName").send_keys("Bob")
    driver.find_element(:name, "passengerLastName").send_keys("Tester")
    driver.find_element(:name, "passengerLastName").submit
    sleep 0.5
  end

  after(:all) do
    driver.quit unless debugging?
  end

  it "[5] Book flight with payment" do
    driver.find_element(:xpath, "//input[@name='card_type' and @value='master']").click
    driver.find_element(:name, "holder_name").send_keys("Bob the Tester")
    driver.find_element(:name, "card_number").send_keys("4242424242424242")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "expiry_month")).select_by(:text, "04")
    Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "expiry_year")).select_by(:text, "2026")
    driver.find_element(:xpath, "//input[@value='Pay now']").click
    try_for(10) { expect(driver.page_source).to include("Booking number") }
    puts("booking number: " + driver.find_element(:id, "booking_number").text)
  end
end
