const AbstractPage = require('./abstract_page');

var webdriver = require('selenium-webdriver'),
    By = webdriver.By,
    until = webdriver.until;

class PaymentPage extends AbstractPage {

  constructor(driver) {
    super(driver);
  }

  async selectVisa() {
    await this.driver.findElement(By.xpath("//input[@name='card_type' and @value='visa']")).click();
  }
  
  async enterHolderName(name) {
    await this.driver.findElement(By.name("holder_name")).sendKeys(name);
  }

  async enterCardNumber(card_no) {
    await this.driver.findElement(By.name("card_number")).sendKeys(card_no);
  }

   
  async selectExpiryMonth(month) {
    await this.driver.findElement(By.name("expiry_month")).sendKeys(month);
  }

  async selectExpiryYear(year) {
    await this.driver.findElement(By.name("expiry_year")).sendKeys(year);
  }

  async clickPayNow() {
    await this.driver.findElement(By.xpath("//input[@value='Pay now']")).click()
  }

};

module.exports = PaymentPage;
