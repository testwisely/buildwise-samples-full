load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Simple Calculator advanced interaction" do
  include TestHelper

  before(:all) do
    @driver = Appium::Driver.new(appium_opts).start_driver
  end
  
  after(:each) do
    while (driver.find_element(:id, "com.simplemobiletools.calculator:id/result").text != "0") do
      driver.find_element(:id, "com.simplemobiletools.calculator:id/btn_clear").click
    end
  end

  after(:all) do
    driver.quit unless debugging?
  end

  it "Compute Power" do
    driver.find_element(:id, "com.simplemobiletools.calculator:id/btn_2").click
    driver.find_element(:id, "com.simplemobiletools.calculator:id/btn_power").click
    driver.find_element(:id, "com.simplemobiletools.calculator:id/btn_5").click
    driver.find_element(:id, "com.simplemobiletools.calculator:id/btn_equals").click
    result = driver.find_element(:id, "com.simplemobiletools.calculator:id/result").text
    puts result
    expect(result).to eq("32")
  end
end
