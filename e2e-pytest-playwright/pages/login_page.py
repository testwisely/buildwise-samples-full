from pages.abstract_page import AbstractPage

class LoginPage(AbstractPage):

  def enter_username(self, user):
    self.driver.fill("#username", user)
 
  def enter_password(self, password):
    self.driver.fill("#password", password)

  def click_sign_in(self):
    self.driver.click("input:has-text('Sign in')")
    