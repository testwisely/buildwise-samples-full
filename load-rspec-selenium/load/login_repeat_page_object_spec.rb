load File.dirname(__FILE__) + "/../test_helper.rb"
load File.dirname(__FILE__) + "/../load_test_helper.rb"

describe "User Login Repeat with Page Objecgt" do
  include TestHelper
  include LoadTestHelper

  before(:all) do
    # browser_type, browser_options, site_url are defined in test_helper.rb
    @driver = $browser = Selenium::WebDriver.for(browser_type, browser_options)
    # driver.manage().window().resize_to(1280, 720)
    driver.get(site_url)
  end

  after(:all) do
    dump_timings
    @driver.quit unless debugging?
  end

  it "[Refactored] User sign in and sign out repeatedly" do
    load_test_repeat.times do
      log_time("Visit Home Page") {
        driver.get(site_url)
        expect(driver.title).to eq("Agile Travel")
      }

      login_page = LoginPage.new(driver)
      login_page.enter_username("agileway")
      login_page.enter_password("testwise")

      log_time("Sign in") {
        login_page.click_sign_in
        expect(flash_notice).to include("Signed in!")
      }

      log_time("Sign out") {
        visit("/logout")
        expect(flash_notice).to include("Signed out!")
      }
    end
  end
end
