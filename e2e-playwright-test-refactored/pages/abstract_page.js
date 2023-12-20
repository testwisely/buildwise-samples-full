class AbstractPage {

  constructor(page) {
    this.page = page;
  }

  async sleep(seconds) {
     await new Promise(resolve => setTimeout(resolve, seconds * 1000));
  }

};


module.exports = AbstractPage;
