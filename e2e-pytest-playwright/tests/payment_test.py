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
from pages.passenger_page import PassengerPage
from pages.payment_page import PaymentPage

@pytest.fixture(autouse=True)
def run_round_test(page: Page):
    page.goto(TestHelper.site_url())
    
    login_page = LoginPage(page)
    login_page.enter_username("agileway")
    login_page.enter_password("testwise")
    login_page.click_sign_in()
    
    flight_page = FlightPage(page)
    flight_page.select_trip_type("oneway")
    flight_page.select_depart_from("Sydney")
    flight_page.select_arrive_at("New York")
    flight_page.select_depart_day("02")
    flight_page.select_depart_month("May 2024")
    flight_page.click_continue()
    
    passenger_page = PassengerPage(page)
    passenger_page.enter_first_name("Bob")
    passenger_page.enter_last_name("Tester")
    passenger_page.click_next()

    
    yield    
    page.close

def test_payment(page: Page):
    payment_page = PaymentPage(page)
    payment_page.select_card_type("visa") 
    payment_page.enter_holder_name("Bob the Tester")
    payment_page.enter_card_number("4242424242424242")
    payment_page.enter_expiry_month("04")
    payment_page.enter_expiry_year("2016")
    payment_page.click_pay_now()
    
    time.sleep(10)
    assert "Booking number" in page.content()


