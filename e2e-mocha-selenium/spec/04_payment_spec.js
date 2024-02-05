var webdriver = require('selenium-webdriver'),
    By = webdriver.By,
    until = webdriver.until;
var test = require('selenium-webdriver/testing');
var assert = require('assert');
const path = require('path');

var driver;
const timeOut = 15000;

String.prototype.contains = function(it) {
  return this.indexOf(it) != -1;
};

var helper = require('../test_helper');

// An example in below:  var FlightPage = require('../pages/flight_page.js')
// BEGIN: import pages

var FlightPage = require('../pages/flight_page.js')
var PassengerPage = require('../pages/passenger_page.js')
var PaymentPage = require('../pages/payment_page.js')

// END: import pages


describe('Payment', function() {

  before(async function() {
    this.timeout(timeOut);
    driver = new webdriver.Builder().forBrowser(helper.browserType()).setChromeOptions(helper.chromeOptions()).build();
    driver.manage().window().setRect({width: 1027, height: 700, x: 30, y: 78})
  });

  beforeEach(async function() {
    this.timeout(timeOut);
    await driver.get(helper.site_url());
    await helper.login(driver, "agileway", "testwise");
    
    let flight_page = new FlightPage(driver);
    await flight_page.selectTripType("oneway")
    await flight_page.selectDepartFrom("New York")
    await flight_page.selectArriveAt("Sydney")
    await flight_page.selectDepartDay("02")
    await flight_page.selectDepartMonth("May 2023")
    await flight_page.clickContinue()

    let passenger_page = new PassengerPage(driver)
    await passenger_page.enterFirstName("Bob")
    await passenger_page.enterLastName("Tester")
    await passenger_page.clickNext();
  });

  afterEach(async function() {
    var testFileName = path.basename(__filename);
    await helper.save_screenshot_after_test_failed(driver, this.currentTest, testFileName);
  });
  
  after(function() {
    if (!helper.is_debugging()) {
      driver.quit();
    }
  });

  it('[5] Book flight with payment', async function() {
    this.timeout(timeOut);

    let payment_page = new PaymentPage(driver)
    await payment_page.selectVisa();
    await payment_page.enterHolderName("Bob the Tester")
    await payment_page.enterCardNumber("4242424242424242");
    await payment_page.selectExpiryMonth("04")
    await payment_page.selectExpiryYear("2025")
    await payment_page.clickPayNow();
    await driver.sleep(10000)
    await driver.findElement(By.tagName("body")).getText().then(function(text) {
      assert(text.contains("Booking number"))
    });
    
  });

});
