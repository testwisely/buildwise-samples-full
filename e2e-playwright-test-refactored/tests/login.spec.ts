import { test, Page, expect } from '@playwright/test';
var path = require("path");

test.describe.configure({ mode: 'serial' });

var helper = require('../test_helper');

//Reuse the page among the test cases in the test script file
// While the Playwright's convention is to use page.xxx
// Personally, Zhimin prefers driver.xxx; feel free to change to use page 
//  let driver: Page; => let page: Page;
let driver: Page;
let page: Page;

test.beforeAll(async ({ browser }) => {
  // Create page once.
  driver = page = await browser.newPage();
});

test.afterAll(async () => {
  await page.close();
});

test.beforeEach(async () => {
  await page.goto('https://travel.agileway.net');
});

test('Sign in OK', async () => {
  await helper.login(page, "agileway", "testwise")
  const flashText = await page.textContent("#flash_notice")
  console.log(flashText);
  expect(flashText).toEqual('Signed in!');
  // page is signed in.
	await driver.locator("text=Sign off").click();
});

test('Sign in failed', async () => {
  await helper.login(page, "agileway", "badpass")
  // const flashText = await driver.textContent("#flash_alert")
  // expect(flashText).toEqual('Invalid email or password');
	await expect(page.locator("#flash_alert")).toHaveText('Invalid email or password');
});