load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Calculator Combination" do
  include TestHelper  # defined in ../test_helper.rb

  before(:all) do
    @driver = Appium::Driver.new(appium_opts).start_driver
  end

  after(:all) do
    @driver.quit unless debugging?
  end

  it "Single digit Combination, Respecting operator priority" do
    main_page = MainPage.new(driver)
    main_page.click_number("four")
    main_page.click_subtract
    main_page.click_number("three")
    driver.find_element(:name, "multiply").click
    main_page.click_number("five")
    main_page.click_equals
    expect(main_page.result).to eq("-11")
  end
end
