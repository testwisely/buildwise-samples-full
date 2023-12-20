const AbstractPage = require('./abstract_page');

class PassengerPage extends AbstractPage {

  constructor(page) {
    super(page);
  }
  
  async enterFirstName(firstName) {
    await this.page.locator("[name=passengerFirstName]").fill(firstName)
  }
      
  async enterLastName(lastName) {
    await this.page.locator("[name=passengerLastName]").fill(lastName)
  }
    
  async clickNext() {
    await this.page.click("input:has-text('Next')")
    this.sleep(0.5)
  }
 
};

module.exports = PassengerPage;
