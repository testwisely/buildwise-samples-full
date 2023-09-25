from pages.abstract_page import AbstractPage


class PaymentPage(AbstractPage):

  def enter_holder_name(self, holder_name):
    self.driver.locator("[name='holder_name']").fill(holder_name)

  def enter_card_number(self, card_number):
    self.driver.locator("[name='card_number']").fill(card_number)

  def enter_expiry_month(self, expiry_month):
    elem = self.driver.locator("[name='expiry_month']")
    elem.select_option(expiry_month)

  def enter_expiry_year(self, expiry_year):
    elem = self.driver.locator("[name='expiry_year']")
    elem.select_option(expiry_year)

  def click_pay_now(self):
    self.driver.locator("//input[@value='Pay now']").click()
 
  def select_card_type(self, card_type):
    self.driver.locator("//input[@name='card_type' and @value='" + card_type + "']").click()
  