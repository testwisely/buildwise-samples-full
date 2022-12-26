load File.dirname(__FILE__) + '/../test_helper.rb'

describe "Test Suite" do
    include TestHelper

    before(:all) do
      @driver = $driver =  if Appium::VERSION.to_i >= 12
        Appium::Driver.new( appium2_opts() ).start_driver
      else
        Appium::Driver.new(app_caps, true).start_driver
      end      
    end

    after(:all) do
      driver.quit unless debugging?
    end

    it "Test Case Name" do
      # driver.find_element(...)
      # expect(page_text).to include(..)
    end

end
