import xmlrunner
import time
import datetime
import sys
import os
import re
from playwright.sync_api import Page, expect
import pytest


# load modules from parent dir, pages will be referred from there too.
sys.path.insert(0, os.path.dirname(os.path.realpath(__file__)) + "/../")
from test_helper import TestHelper
from pages.login_page import LoginPage
from pages.flight_page import FlightPage

@pytest.fixture(autouse=True)
def run_round_test(page: Page):
    page.goto(TestHelper.site_url())
    login_page = LoginPage(page)
    login_page.enter_username("agileway")
    login_page.enter_password("testwise")
    login_page.click_sign_in()
    
    yield
    
    page.close

def test_oneway_flight(page: Page):
    flight_page = FlightPage(page)
    flight_page.select_trip_type("oneway")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")

    flight_page.select_depart_day("02")
    flight_page.select_depart_month("May 2024")
    flight_page.click_continue()
    time.sleep(1)


def test_return_flight(page: Page):
    flight_page = FlightPage(page)
    flight_page.select_trip_type("return")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")

    flight_page.select_depart_day("02")
    flight_page.select_depart_month("May 2024")
    flight_page.click_continue()
    time.sleep(1)

