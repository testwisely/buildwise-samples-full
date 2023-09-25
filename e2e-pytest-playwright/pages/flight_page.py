from pages.abstract_page import AbstractPage

class FlightPage(AbstractPage):

  def select_trip_type(self, trip_type):
    elem = self.driver.locator("//input[@name='tripType' and @value='" + trip_type + "']")
    elem.click()

  def select_depart_from(self, from_port):
    select_elem = self.driver.locator("//select[@name='fromPort']")
    select_elem.select_option(from_port)

  def select_arrive_at(self, to_port):
    select_elem = self.driver.locator("//select[@name='toPort']")
    select_elem.select_option(to_port)

  def select_depart_day(self, depart_day):
    select_elem = self.driver.locator("//select[@name='departDay']")
    select_elem.select_option(depart_day)

  def select_depart_month(self, depart_month):
    select_elem = self.driver.locator("#departMonth")
    select_elem.select_option(depart_month)

  def select_return_day(self, return_day):
    Select(self.driver.find_element_by_name("returnDay")).select_by_visible_text(return_day)

  def select_return_month(self, return_month):
    Select(self.driver.find_element_by_id("returnMonth")).select_by_visible_text(return_month)

  def click_continue(self):
    self.driver.locator("//input[@value='Continue']").click()
