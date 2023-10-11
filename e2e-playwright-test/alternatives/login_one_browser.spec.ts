import { test, Page, expect } from '@playwright/test';

test.describe.configure({ mode: 'serial' });

//Reuse the page among the test cases in the test script file
// While the Playwright's convention is to use page.xxx
// Personally, Zhimin prefers driver.xxx; feel free to change to use page 
//  let driver: Page; => let page: Page;
let driver: Page;

test.beforeAll(async ({ browser }) => {
  // Create page once.
  driver = await browser.newPage();
});

test.afterAll(async () => {
  await driver.close();
});

test.beforeEach(async () => {
  await driver.goto('https://travel.agileway.net');
});

test('Sign in OK', async () => {
  await driver.fill("#username", "agileway");
  await driver.fill("#password", "testwise");
  await driver.click("input:has-text('Sign in')");
  const flashText = await driver.textContent("#flash_notice")
  console.log(flashText);
  expect(flashText).toEqual('Signed in!');
  // page is signed in.
	await driver.locator("text=Sign off").click();
});

test('Sign in failed', async () => {
  await driver.fill("#username", "agileway");
  await driver.fill("#password", "badpass");
  await driver.click("input:has-text('Sign in')");
  // const flashText = await driver.textContent("#flash_alert")
  // expect(flashText).toEqual('Invalid email or password');
	await expect(driver.locator("#flash_alert")).toHaveText('Invalid email or password');
	
});