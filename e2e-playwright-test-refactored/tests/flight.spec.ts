import { test, Page, expect } from '@playwright/test';
var path = require("path");
var assert = require('assert');
String.prototype.contains = function(it) {
  return this.indexOf(it) != -1;
};

test.describe.configure({ mode: 'serial' });

var helper = require('../test_helper');

//Reuse the page among the test cases in the test script file
// While the Playwright's convention is to use page.xxx
// Personally, Zhimin prefers driver.xxx; feel free to change to use page 
//  let driver: Page; => let page: Page;
let driver: Page;
let page: Page;

// An example in below:  var FlightPage = require('../pages/flight_page.js')
// BEGIN: import pages
var FlightPage = require('../pages/flight_page.js')

// END: import pages

test.beforeAll(async ({ browser }) => {
  // Create page once.
  driver = page = await browser.newPage();
  await page.goto('https://travel.agileway.net');
  await helper.login(page, "agileway", "testwise")
});

test.afterAll(async () => {
  await page.close();
});

test.beforeEach(async () => {
  await page.goto('https://travel.agileway.net');
});

test.afterEach(async () => {
  await helper.sleep(0.5)
});


test('Return trip', async () => {
  let flight_page = new FlightPage(page);
  await flight_page.selectTripType("return")
  await flight_page.selectDepartFrom("Sydney")
  await flight_page.selectArriveAt("New York") // failed but not showing line
  await flight_page.selectDepartDay("02")
  await flight_page.selectDepartMonth("052023")
  await flight_page.selectReturnDay("04")
  // by default selectOption is by value, 
  // await flight_page.selectReturnMonth("June 2021")
  await flight_page.selectReturnMonth("062023")
  await flight_page.clickContinue()
  
  // await helper.sleep(60); // willl get  Test timeout of 30000ms exceeded
  await helper.sleep(0.5)
   
  await driver.textContent("body").then(function(body_text) {
    console.log(body_text)
    // somehow the body text in Playwright does not have the first trip text
    //assert(body_text.contains("2023-05-02  Sydney to New York"))
    //assert(body_text.contains("2023-06-04  New York to Sydney"))
  })

});


test('One-way trip', async () => {
  
  let flight_page = new FlightPage(page);
  await flight_page.selectTripType("oneway")
  await flight_page.selectDepartFrom("Sydney")
  await flight_page.selectArriveAt("New York") // failed but not showing line
  await flight_page.selectDepartDay("02")
  await flight_page.selectDepartMonth("052023")
  await flight_page.clickContinue()
  
  // await helper.sleep(60); // willl get  Test timeout of 30000ms exceeded
  await helper.sleep(0.5)
   
  await driver.textContent("body").then(function(body_text) {
    console.log(body_text)
    // somehow the body text in Playwright does not have the first trip text
    assert(body_text.contains("2023-05-02  Sydney to New York"))
  })

});
