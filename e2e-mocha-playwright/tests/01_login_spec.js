const {  test, expect } = require('@playwright/test');
const { chromium } = require('playwright');
var path = require("path");
var assert = require('assert');

const timeOut = 15000;
let driver, page, browser, context

String.prototype.contains = function(it) {
  return this.indexOf(it) != -1;
};

var helper = require('../test_helper');

// An example in below:  var FlightPage = require('../pages/flight_page.js')
// BEGIN: import pages
// END: import pages
describe('User Authentication', function() {
	this.timeout(5000);
  before(async function() {
    browser = await chromium.launch({
      headless: false,
    });
    context = await browser.newContext();
    driver = page = await context.newPage();
  });

  beforeEach(async function() {
    await driver.goto('https://travel.agileway.net');
  });

  after(async function() {
      browser.close();
  });

  afterEach(async function() {
    var testFileName = path.basename(__filename);
    await helper.save_screenshot_after_test_failed(page, this.currentTest, testFileName);
  });

  it('[1,2] Invalid user', async function() {
    await driver.title().then(function(the_title) {
     // console.log(the_title)
    })
    await driver.fill("#username", "agileway")
    await driver.fill("#password", "playwright") // fail it
    await driver.click("input:has-text('Sign in')")
    await driver.textContent("body").then(function(body_text) {
      //console.log(body_text)
      assert(body_text.contains("Invalid email or password"))
    })
  });
  
  it('User can login successfully', async function() {
    await driver.fill("#username", "agileway")
    await driver.fill("#password", "testwise")
    await driver.click("input:has-text('Sign in')")
    await driver.textContent("body").then(function(body_text) {
      //console.log(body_text)
      assert(body_text.contains("Signed in"))
    })
    await driver.click("a:has-text('Sign off')")
		
		// sleep 1 second, like Ruby's sleep(1)
		await new Promise(resolve => setTimeout(resolve, 1000));
  });

});
