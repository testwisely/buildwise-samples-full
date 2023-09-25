import unittest
import xmlrunner
import time
import datetime
import sys
import os

from playwright.sync_api import Page, expect
import pytest

sys.path.insert(0, os.path.dirname(os.path.realpath(__file__)) + "/../")
from test_helper import TestHelper

from pages.login_page import LoginPage
from pages.flight_page import FlightPage
from pages.passenger_page import PassengerPage

class PassengerTestCase(unittest.TestCase, TestHelper):

  @classmethod
  def setUpClass(cls):
    # open_browser method defined in test_helper.py
    # cls.driver = cls.open_browser();
    # cls.driver.set_window_size(1280, 720)
    # cls.driver.set_window_position(30, 78)

    # cls.driver.get(cls.site_url())
    # login_page = LoginPage(cls.driver)
    # login_page.enter_username("agileway")
    # login_page.enter_password("testwise")
    # login_page.click_sign_in()
    print("cls setup is not good yet")

  @classmethod
  def tearDownClass(cls):
    time.sleep(1)

  @pytest.fixture(autouse=True)
  def setup(self, page: Page):
    self.driver = page
    self.driver.goto(self.site_url())
    login_page = LoginPage(self.driver)
    login_page.enter_username("agileway")
    login_page.enter_password("testwise")
    login_page.click_sign_in()

  def test_enter_passenger_details(self):
    flight_page = FlightPage(self.driver)
    flight_page.select_trip_type("oneway")
    flight_page.select_depart_from("New York")
    flight_page.select_arrive_at("Sydney")
    flight_page.select_depart_day("04")
    flight_page.select_depart_month("March 2023")
    flight_page.click_continue()

    time.sleep(1)
    passenger_page = PassengerPage(self.driver)
    passenger_page.enter_first_name("Bob")
    passenger_page.enter_last_name("Tester")
    passenger_page.click_next()

    # purposely assertion failure
    self.assertEqual("Wendy Tester", self.driver.locator("//input[@name='holder_name']").get_attribute("value"))

# if __name__ == '__main__':
#     unittest.main(
#         testRunner=xmlrunner.XMLTestRunner(output='reports'),
#         failfast=False, buffer=False, catchbreak=False)
