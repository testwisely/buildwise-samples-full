load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Simple Calculator basic interaction" do
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

  it "Compute Sum" do
    driver.find_element(:id, "com.simplemobiletools.calculator:id/btn_2").click
    driver.find_element(:id, "com.simplemobiletools.calculator:id/btn_plus").click
    driver.find_element(:id, "com.simplemobiletools.calculator:id/btn_5").click
    driver.find_element(:id, "com.simplemobiletools.calculator:id/btn_equals").click
    result = driver.find_element(:id, "com.simplemobiletools.calculator:id/result").text
    puts result
    expect(result).to eq("7")
  end

  it "Clear Result Number" do
    driver.find_element(:id, "com.simplemobiletools.calculator:id/btn_1").click
    driver.find_element(:id, "com.simplemobiletools.calculator:id/btn_2").click
    result = driver.find_element(:id, "com.simplemobiletools.calculator:id/result").text
    puts result
    expect(result).to eq("12")

    driver.find_element(:id, "com.simplemobiletools.calculator:id/btn_clear").click
    result = driver.find_element(:id, "com.simplemobiletools.calculator:id/result").text
    puts result
    expect(result).to eq("1")
  end

end
