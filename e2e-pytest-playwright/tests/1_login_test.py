import unittest
import xmlrunner
import time
import datetime
import sys
import os
import re
from playwright.sync_api import Page, expect
# from playwright.sync_api import sync_playwright
import pytest

# load modules from parent dir, pages will be referred from there too.
sys.path.insert(0, os.path.dirname(os.path.realpath(__file__)) + "/../")
from test_helper import TestHelper
from pages.login_page import LoginPage


class LoginTestCase(unittest.TestCase, TestHelper):
 
 
  @classmethod
  def setUpClass(cls):
    print("setUpClass") 
    

  @pytest.fixture(autouse=True)
  def setup(self, page: Page):
    print("setup")
    self.page = page
    self.page.goto("https://travel.agileway.net")
        
  def test_sign_in_failed(self):
    login_page = LoginPage(self.page)
    login_page.enter_username("agileway")
    login_page.enter_password("badpass")
    login_page.click_sign_in()
    assert "Invalid email or password" in self.page.content();

  def test_sign_in_ok(self):
    # self.page.goto("https://travel.agileway.net")
    login_page = LoginPage(self.page)
    login_page.enter_username("agileway")
    login_page.enter_password("testwise")
    login_page.click_sign_in()
    assert self.page.text_content("div#flash_notice") == "Signed in!"

# if __name__ == '__main__':
#     unittest.main(
#         testRunner=xmlrunner.XMLTestRunner(output='reports'),
#         failfast=False, buffer=False, catchbreak=False)
