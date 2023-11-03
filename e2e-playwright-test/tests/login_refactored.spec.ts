
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

test('Test Case Name', async () => {
  await 
});



