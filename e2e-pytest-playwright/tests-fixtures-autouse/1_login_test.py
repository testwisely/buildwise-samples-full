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
    self.driver = self.page =  page
    self.driver.goto(self.site_url())
        
  def test_sign_in_failed(self):
    login_page = LoginPage(self.driver)
    login_page.enter_username("agileway")
    login_page.enter_password("badpass")
    login_page.click_sign_in()
    assert "Invalid email or password" in self.page.content();

  def test_sign_in_ok(self):
    login_page = LoginPage(self.driver)
    login_page.enter_username("agileway")
    login_page.enter_password("testwise")
    login_page.click_sign_in()
    assert self.driver.text_content("div#flash_notice") == "Signed in!"
