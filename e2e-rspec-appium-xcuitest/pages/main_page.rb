
require File.join(File.dirname(__FILE__), "abstract_page.rb")

class MainPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def enter_amount(amount)
    elem_input = driver.find_element(:xpath, "//XCUIElementTypeApplication[@name=\"iCurrency\"]//XCUIElementTypeTextField")
    elem_input.clear
    elem_input.send_keys("#{amount}")
  end




  def click_convert
    elem_convert = driver.find_element :name, "Convert"
    elem_convert.click
    sleep 0.2
  end


  def euro_amount
    # try Xpath on http://xpather.com/
    elem_euro_amount = driver.find_element(:xpath, "//XCUIElementTypeApplication[@name='iCurrency']//XCUIElementTypeStaticText[@name='€']/following-sibling::XCUIElementTypeStaticText[position()=1]")
    new_euro_amount = elem_euro_amount.text.to_f
  end
end






