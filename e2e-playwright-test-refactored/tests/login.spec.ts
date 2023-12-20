import { test, Page, expect } from '@playwright/test';
var path = require("path");

test.describe.configure({ mode: 'serial' });

var helper = require('../test_helper');

//Reuse the page among the test cases in the test script file
let page: Page;

// BEGIN: import pages
// var FooPage = require('../pages/foo_page.js')

// END: import pages


test.beforeAll(async ({ browser }) => {
  // Create page once.
  page = await browser.newPage();
});

test.afterAll(async () => {
  await page.close();
});

test.beforeEach(async () => {
  await page.goto(helper.site_url());
});

test('Sign in OK', async () => {
  await page.fill("#username", "agileway");
  await page.fill("#password", "testwise");
  await page.click("input:has-text('Sign in')");
  const flashText = await page.textContent("#flash_notice")
  console.log(flashText);
  expect(flashText).toEqual('Signed in!');
  // page is signed in.
	await page.locator("text=Sign off").click();
});

test('Sign in failed', async () => {
  await page.fill("#username", "agileway");
  await page.fill("#password", "badpass");
  await page.click("input:has-text('Sign in')");
  // const flashText = await page.textContent("#flash_alert")
  // expect(flashText).toEqual('Invalid email or password');
	await expect(page.locator("#flash_alert")).toHaveText('Invalid email or password');
	
});