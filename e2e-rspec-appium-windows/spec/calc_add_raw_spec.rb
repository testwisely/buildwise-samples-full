load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Calculator on Windows Raw" do
  include TestHelper

  before(:all) do
    @driver = $driver = if Appium::VERSION.to_i >= 12
        Appium::Driver.new(appium2_opts()).start_driver
      else
        Appium::Driver.new(app_caps, true).start_driver
      end
  end

  after(:all) do
    driver.quit unless debugging?
  end

  it "Single digit and subtract" do
    driver.find_element(:name, "Four").click
    driver.find_element(:name, "Plus").click
    driver.find_element(:name, "Three").click
    driver.find_element(:name, "Minus").click
    driver.find_element(:name, "Two").click
    driver.find_element(:name, "Equals").click

    the_result = driver.find_element(:accessibility_id, "CalculatorResults").text
    expect(the_result).to eq("Display is 5")
  end
end
