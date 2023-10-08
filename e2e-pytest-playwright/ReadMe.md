There are serveral ways to structure Playwright with Pytest. For this simple reason, I much prefer Selenium RSpec. 

This fold contains three ways (for Sync Playwright only).


1. Non-TestCase

This whole test script is unittest.TestCase, but pytest can run them.

Example: 

def test_sign_in_ok(page: Page):
    page.goto("https://travel.agileway.net")
    login_page = LoginPage(page)
    
The page instance is "magically" set. 

For every test case, a new chromium browser instance is launched (and close).

2. TestCase using fixture to autoset page 

  @pytest.fixture(autouse=True)
  def setup(self, page: Page):
    self.driver = self.page =  page
    self.driver.goto(self.site_url())

setup() is a fixture runs before each test case. In other words, a new chromium browser instance is launched (and close) for each test case.

3. (TODO) Only one browser instance per unittest.TestCase class, like RSpec

   Referrence: but seems not working (playwright = Playwright() failed)
   
  import unittest
  from playwright.sync_api import Playwright, Browser
 
  class MyTests(unittest.TestCase):
      @classmethod
      def setUpClass(cls):
          # Launch a new browser instance
          playwright = Playwright()
          browser_type = playwright.chromium
          cls.browser = browser_type.launch(headless=False)
          # Create a new page
          cls.page = cls.browser.new_page()
 
      @classmethod
      def tearDownClass(cls):
          # Close the browser
          cls.browser.close()
 
      def test_login_form(self):
          self.page.goto("https://example.com/login")
          self.page.fill("#username", "myusername")
          self.page.fill("#password", "mypassword")
          self.page.click("#submit")
          assert "Welcome" in self.page.title()  