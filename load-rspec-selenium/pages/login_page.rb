require File.join(File.dirname(__FILE__), "abstract_page.rb")

class LoginPage < AbstractPage

  def initialize(driver)
    super(driver, "")
  end

  def enter_username(username)
    driver.find_element(:id, "username").send_keys(username)
  end

  def enter_password(password)
    driver.find_element(:id, "password").send_keys(password)
  end


  def click_sign_in
    driver.find_element(:name, "commit").click
  end
  
  
  def login(user, pass)
    @browser.find_element(:id, "username").send_keys(user)
    @browser.find_element(:id, "password").send_keys(pass)
    @browser.find_element(:id, "username").submit
  end
end






