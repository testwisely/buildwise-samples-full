namespace e2e_vstest_selenium;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;
using OpenQA.Selenium.Support.UI;

[TestClass]
public class FlightTest
{
    static IWebDriver driver = null;

    [ClassInitialize()]
    public static void BeforeAll(TestContext context) {
        driver = new ChromeDriver();
        driver.Manage().Window.Size = new System.Drawing.Size(1280, 720);
        driver.Manage().Window.Position = new System.Drawing.Point(30, 78);
        driver.Navigate().GoToUrl("http://travel.agileway.net");
        driver.FindElement(By.Name("username")).SendKeys("agileway");
        driver.FindElement(By.Name("password")).SendKeys("testwise");
        driver.FindElement(By.Name("password")).Submit();
    }

    [TestInitialize]
    public void BeforeTest() {
        driver.Navigate().GoToUrl("http://travel.agileway.net/");
    }

    [TestCleanup]
    public void AfterTest() {
    // run after each test case
    }

    [ClassCleanup()]
    public static void AfterAll() {
      driver.Quit();
    }

    [TestMethod]
    public void TestReturnTrip()
    {
        // System.Threading.Thread.Sleep(1000); 
         driver.FindElement(By.XPath("//input[@name='tripType' and @value='return']")).Click();
         IWebElement elem = driver.FindElement(By.Name("fromPort"));
         SelectElement select = new SelectElement(elem);
         select.SelectByText("Sydney");

         elem = driver.FindElement(By.Name("toPort"));
         new SelectElement(elem).SelectByText("New York");

         elem = driver.FindElement(By.Id("departDay"));
         new SelectElement(elem).SelectByText("02");

         elem = driver.FindElement(By.Id("departMonth"));
         new SelectElement(elem).SelectByText("May 2023");

         elem = driver.FindElement(By.Id("returnDay"));
         new SelectElement(elem).SelectByText("04");

         elem = driver.FindElement(By.Id("returnMonth"));
         new SelectElement(elem).SelectByText("June 2023");

        driver.FindElement(By.XPath("//input[@value='Continue']")).Click();

        Assert.IsTrue(driver.FindElement(By.TagName("body")).Text.Contains("2023-05-02 Sydney to New York"));
        Assert.IsTrue(driver.FindElement(By.TagName("body")).Text.Contains("2023-06-04 New York to Sydney"));
    }

      [TestMethod]
    public void TestOnewayTrip()
    {
        // System.Threading.Thread.Sleep(1000); 
         driver.FindElement(By.XPath("//input[@name='tripType' and @value='oneway']")).Click();
         IWebElement elem = driver.FindElement(By.Name("fromPort"));
         SelectElement select = new SelectElement(elem);
         select.SelectByText("Sydney");

         elem = driver.FindElement(By.Name("toPort"));
         new SelectElement(elem).SelectByText("New York");

         elem = driver.FindElement(By.Id("departDay"));
         new SelectElement(elem).SelectByText("02");

         elem = driver.FindElement(By.Id("departMonth"));
         new SelectElement(elem).SelectByText("May 2023");

        driver.FindElement(By.XPath("//input[@value='Continue']")).Click();

        Assert.IsTrue(driver.FindElement(By.TagName("body")).Text.Contains("2023-05-02 Sydney to New York"));
    }

}