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

# https://playwright.dev/python/docs/test-runners

# load modules from parent dir, pages will be referred from there too.
sys.path.insert(0, os.path.dirname(os.path.realpath(__file__)) + "/../")
from test_helper import TestHelper
from pages.login_page import LoginPage

@pytest.mark.only_browser("chromium")
def test_sign_in_failed(page: Page):
    page.goto("https://travel.agileway.net")
    login_page = LoginPage(page)
    login_page.enter_username("agileway")
    login_page.enter_password("badpass")
    login_page.click_sign_in()
    # using page_source for assertion
    assert "Invalid email or password" in page.content();
    # expect(page.locator("//body")).to_have_text("Invalid email or password")
    # self.assertIn("Demo Fail this test case", self.driver.find_element_by_tag_name("body").text)

def test_sign_in_ok(page: Page):
    page.goto("https://travel.agileway.net")
    login_page = LoginPage(page)
    login_page.enter_username("agileway")
    login_page.enter_password("testwise")
    login_page.click_sign_in()
    assert page.text_content("div#flash_notice") == "Signed in!"

# if __name__ == '__main__':
#     unittest.main(
#         testRunner=xmlrunner.XMLTestRunner(output='reports'),
#         failfast=False, buffer=False, catchbreak=False)
