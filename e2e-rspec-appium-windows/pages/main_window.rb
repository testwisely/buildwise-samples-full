
require File.join(File.dirname(__FILE__), "abstract_page.rb")

class MainWindow < AbstractWindow

  def initialize(driver, title = "")
    super(driver, title) # <= WIN TITLE
  end

  def click_number(number)
    win.find_element(:name, number).click
  end


  def click_plus
    win.find_element(:name, "Plus").click
  end
  
  
  def click_minus
    win.find_element(:name, "Minus").click
  end

  def click_equals
    win.find_element(:name, "Equals").click
  end


  def result
    win.find_element(:accessibility_id, "CalculatorResults").text
  end
end








