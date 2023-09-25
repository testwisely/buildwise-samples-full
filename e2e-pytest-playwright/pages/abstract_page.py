from playwright.sync_api import Page, expect
from playwright.sync_api import sync_playwright

class AbstractPage(object):

  def __init__(self, driver):
    self.driver = driver
