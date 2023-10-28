const { chromium } = require('playwright');
var assert = require('assert');

const fs = require('fs');
const path = require('path');

function debuggingPort() {
    var port_number = Math.floor((Math.random() * 40000) + 16000);
    var port_number_str = "" + port_number;
    fs.writeFile(portFile(), port_number_str, function(err) {});
    return port_number_str;
}

function getDebuggingPort() {
  return fs.readFileSync(portFile());
}

function portFile() {
  var port_number_file_path = path.join(__dirname, "port_number.txt")
  return port_number_file_path;
}

module.exports = {

    browserType: function() {
        if (process.env.BROWSER) {
            return process.env.BROWSER;
        } else {
            return "chrome";
        }
    },


    is_debugging: function() {
        return (process.env.RUN_IN_TESTWISE == "true" && process.env.TESTWISE_RUNNING_AS == "test_case");
    },
    
    
    site_url: function() {
        if (process.env.BASE_URL) {
            return process.env.BASE_URL;
        } else {
            return "https://travel.agileway.net";
        }
    },

};

async function save_screenshot_after_test_failed(page, currentTest, testFileName) {
    if (currentTest.state != "passed") {
        // console.log("Trying to take a screenshot of " + currentTest.fullTitle());
        var screenshot_file_dir = __dirname + '/reports/screenshots/' + testFileName.replace(".js", ".xml");
        var screenhost_file_name = currentTest.fullTitle() + ".png";
        var screenshot_file_path = screenshot_file_dir + "/" + screenhost_file_name;
        await page.screenshot({ path: screenshot_file_path });
    }
}

async function sleep(seconds) {
  await new Promise(resolve => setTimeout(resolve, seconds * 1000));
}


// BEGIN: user functions
async function login(page, username, password) {
  await page.fill("#username", username);
  await page.fill("#password", password);
  await page.click("input:has-text('Sign in')");
}

// END: user functions


// BEGIN: module exports
module.exports.save_screenshot_after_test_failed = save_screenshot_after_test_failed;
module.exports.sleep = sleep;

module.exports.login = login;
// END: module exports