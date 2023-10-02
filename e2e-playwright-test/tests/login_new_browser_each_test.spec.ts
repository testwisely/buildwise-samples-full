const { chromium } = require('playwright');
import { test, expect } from '@playwright/test';

// TODO, currently every test starts a new browser

test.beforeAll(async () => {
  console.log('Before ALL tests');
  // ...
});


test.afterAll(async () => {
  console.log('After ALL tests');
  // ...
});


test.beforeEach(async ({ page }, testInfo) => {
  console.log(`About to run test case:  ${testInfo.title}`);
  await page.goto('https://travel.agileway.net');
});


test.afterEach(async () => {
  console.log('After EACH tests');
  // ...
});

test('Login OK', async ({ page }) => {
  await page.fill("#username", "agileway");
  await page.fill("#password", "testwise");
  await page.click("input:has-text('Sign in')");
  const flashText = await page.textContent("#flash_notice")
  console.log(flashText);
  expect(flashText).toEqual('Signed in!');
  // expect(flashText).toContain('Signed in!');
  
});


test('Login Failed', async ({ page }) => {
  await page.fill("#username", "agileway");
  await page.fill("#password", "testwise");
  await page.click("input:has-text('Sign in')");
  const element = await page.getByText("Invalid email or password")
  await expect(element !== undefined ).toBeTruthy();
});

