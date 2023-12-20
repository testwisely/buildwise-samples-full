const AbstractPage = require('./abstract_page');

class PaymentPage extends AbstractPage {

  constructor(page) {
    super(page);
  }
  
  async selectVisa() {
    await this.page.getByRole('radio').first().check();
    
    // NOTE: this will wait about 30 seconds then time out, no good, Selenium is much better
    // 
    // await this.page.getByRole("radio", {name: 'card_type', value: 'visa'}).check()
  }
      
  async enterCardNumber(cardNumber) {
    await this.page.locator("[name=card_number]").fill(cardNumber)
  }
    
  async clickPayNow() {
    await this.page.getByRole('button', { name: 'Pay now' }).click();
  }
 
};

module.exports = PaymentPage;
