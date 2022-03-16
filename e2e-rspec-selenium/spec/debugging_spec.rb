# Special test that uses last browser window (from a TestWise run)
# Then you can try Selenium commands directly on the page, without the need to restart from the beginning.

load File.dirname(__FILE__) + "/../test_helper.rb"

describe "DEBUG" do
  include TestHelper

  before(:all) do
    use_current_browser
  end

  it "Debugging" do
    body_text = driver.find_element(:tag_name, "body").text
    booking_number = nil 
    if body_text =~ /Booking number:\s+(\d+)/
      booking_number = $1
    end
    puts booking_number
    end
end

