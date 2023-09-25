from pages.abstract_page import AbstractPage

class PassengerPage(AbstractPage):

  def enter_first_name(self, passenger_first_name):
    self.driver.locator("[name='passengerFirstName']").fill(passenger_first_name)

  def enter_last_name(self, passenger_last_name):
    self.driver.locator("[name='passengerLastName']").fill(passenger_last_name)

  def click_next(self):
    self.driver.locator("//input[@value='Next']").click() 