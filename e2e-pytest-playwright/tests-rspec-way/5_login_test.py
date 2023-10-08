import unittest
from playwright.sync_api import Playwright, Browser
 
class LoginTests(unittest.TestCase):
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
 
if __name__ == '__main__':
    unittest.main()