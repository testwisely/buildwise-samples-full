load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Set up" do
  include TestHelper

  before(:all) do
    app_path = File.expand_path File.join(File.dirname(__FILE__), "..", "apps", "iCurrency.app.zip")
    @driver = Appium::Driver.new(simulator_opts(:app => app_path)).start_driver
  end

  after(:all) do
    @driver.quit
  end
  
  # WebDriverAgentRunner has conflicting provisioning settings. WebDriverAgentRunner is automatically signed, but code signing identity 489C89LARQ has been manually specified. Set the code signing identity value to "Apple Development" in the build settings editor, or switch to manual signing in the Signing & Capabilities editor.

  it "Install and Launch iCurrency on iOS Simulator" do
    puts "Abbout get name"
    application_element = @driver.find_element :class_name, "XCUIElementTypeApplication"
    application_name = application_element.attribute :name
    expect(application_name).to eq("iCurrency")
  end
end
