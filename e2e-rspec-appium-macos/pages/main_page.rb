
require File.join(File.dirname(__FILE__), "abstract_page.rb")

class MainPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def click_number(num)
    driver.find_element(:name, num).click
  end


  def click_add
    driver.find_element(:name, "add").click
  end
  def click_subtract
    driver.find_element(:name, "subtract").click
  end
  def click_equals
    driver.find_elements(:name, "equals").last.click
  end
  def result
    driver.find_element(:name, "main display").text
  end
end




