load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Appium Set up - Simulator" do
  include TestHelper

  before(:all) do
    app_path = File.expand_path File.join(File.dirname(__FILE__), "..", "apps", "iCurrency.app.zip")
    @driver = Appium::Driver.new(simulator_opts(:app => app_path)).start_driver
  end

  after(:all) do
    puts "Quit driver"
    @driver.quit
  end
  
  it "Install and Launch iCurrency on iOS Simulator" do
    puts "Abbout get app name"
    application_element = @driver.find_element :class_name, "XCUIElementTypeApplication"
    application_name = application_element.attribute :name
    expect(application_name).to eq("iCurrency")
    puts "Done"
  end
end
