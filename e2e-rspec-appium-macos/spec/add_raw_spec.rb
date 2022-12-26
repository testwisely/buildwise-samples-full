load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Calculator on macOS" do
  include TestHelper  # defined in ../test_helper.rb

  before(:all) do
    @driver = Appium::Driver.new(appium_opts).start_driver
  end

  def driver
    return @driver
  end
  
  after(:all) do
    @driver.quit unless debugging?
  end

  it "Single digit and subtract" do
    driver.find_element(:name, "four").click
    driver.find_element(:name, "add").click
    driver.find_element(:name, "three").click
    driver.find_element(:name, "subtract").click
    driver.find_element(:name, "two").click

    # puts driver.find_elements(:name, "equals").count # => 2
    # driver.find_element(:name, "equals").click # not working not failed, maybe a hidden one
    driver.find_elements(:name, "equals").last.click

    the_result = driver.find_element(:name, "main display").text
    expect(the_result).to eq("5")
  end

end
