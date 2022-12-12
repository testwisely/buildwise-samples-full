load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Convert - Simulator - POM" do
  include TestHelper

  before(:all) do
    app_path = File.expand_path File.join(File.dirname(__FILE__), "..", "apps", "iCurrency.app.zip")
    @driver = Appium::Driver.new(simulator_opts(:app => app_path)).start_driver
  end

  after(:all) do
    @driver.quit unless debugging?
  end

  it "Convert a new amount - Simulator - Page Objects" do
    main_page = MainPage.new(driver)
    expect(main_page.euro_amount).to be > 80
    main_page.enter_amount(50)
    main_page.click_convert
    expect(main_page.euro_amount).to be < 50
  end
end
