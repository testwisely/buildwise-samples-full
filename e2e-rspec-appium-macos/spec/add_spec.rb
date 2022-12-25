load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Calculator Add" do
  include TestHelper  # defined in ../test_helper.rb

  before(:all) do
    @driver = Appium::Driver.new(appium_opts).start_driver
  end

  after(:all) do
    @driver.quit unless debugging?
  end

  it "Single digit Add" do
    main_page = MainPage.new(driver)
    main_page.click_number("four")
    main_page.click_add
    main_page.click_number("three")
    main_page.click_equals
    expect(main_page.result).to eq("7")
  end
end
