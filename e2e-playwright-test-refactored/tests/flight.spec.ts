import { test, Page, expect } from '@playwright/test';
var path = require("path");

test.describe.configure({ mode: 'serial' });

var helper = require('../test_helper');

//Reuse the page among the test cases in the test script file
let page: Page;

// An example in below:  var FlightPage = require('../pages/flight_page.js')
// BEGIN: import pages
// var FooPage = require('../pages/foo_page.js')
var FlightPage = require('../pages/flight_page.js')

// END: import pages

test.beforeAll(async ({ browser }) => {
  // Create page once.
  page = await browser.newPage();
  await page.goto(helper.site_url());
  await helper.login(page, "agileway", "testwise")
});

test.afterAll(async () => {
  await page.close();
});

test.beforeEach(async () => {
  await page.goto(helper.site_url());
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
  await flight_page.selectDepartMonth("052025")
  await flight_page.selectReturnDay("04")
  // by default selectOption is by value, 
  // await flight_page.selectReturnMonth("June 2021")
  await flight_page.selectReturnMonth("062025")
  await flight_page.clickContinue()
  
  // await helper.sleep(60); // willl get  Test timeout of 30000ms exceeded
  await helper.sleep(0.5)
  
  //await expect(page.textContent('body')).toHaveText('2023-05-02  Sydney to New York');
   
  await page.textContent("body").then(function(body_text) {
    console.log(body_text)
    // somehow the body text in Playwright does not have the first trip text
    expect(body_text.contains("2025-05-02   Sydney to New York")).toBeTruthy();
    expect(body_text.contains("2025-06-04  New York to Sydney")).toBeTruthy();
  })

});


test('One-way trip', async () => {
  
  let flight_page = new FlightPage(page);
  await flight_page.selectTripType("oneway")
  await flight_page.selectDepartFrom("Sydney")
  await flight_page.selectArriveAt("New York") // failed but not showing line
  await flight_page.selectDepartDay("02")
  await flight_page.selectDepartMonth("052025")
  await flight_page.clickContinue()
  
  await helper.sleep(0.5)  

  await page.textContent("body").then(function(body_text) {
    console.log(body_text)
    expect(body_text.contains("2025-05-02   Sydney to New York")).toBeTruthy();
  })

});
