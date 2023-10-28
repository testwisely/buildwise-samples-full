# https://playwright.dev/docs/running-tests

1. Run test script
   
   npx playwright test --headed tests/login.spec.ts

2. Run a specific test case
   
   npx playwright test --headed tests/login.spec.ts -g "Sign in OK"


3. Run a specific test case with junit
   
    PLAYWRIGHT_JUNIT_OUTPUT_NAME=results.xml npx playwright test --headed tests/login.spec.ts -g "Sign in OK" --reporter=junit


4. Run with time travelling mode:
   
   npx playwright test --headed --ui tests/login.spec.ts


5. Run with debugging mode:
   (run step by step)
   
   npx playwright test --headed --uiatests/login.spec.ts --debug
