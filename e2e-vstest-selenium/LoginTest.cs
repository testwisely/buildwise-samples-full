namespace e2e_vstest_selenium;
using OpenQA.Selenium;
using OpenQA.Selenium.Chrome;

[TestClass]
public class LoginTest
{
    static IWebDriver driver = null;

    [ClassInitialize()]
    public static void BeforeAll(TestContext context) {
        driver = new ChromeDriver();
        driver.Navigate().GoToUrl("http://travel.agileway.net");
    }

    [TestInitialize]
    public void BeforeTest() {
        driver.Navigate().GoToUrl("http://travel.agileway.net/login");
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
    public void TestLoginOK()
    {
        driver.FindElement(By.Name("username")).SendKeys("agileway");
        driver.FindElement(By.Name("password")).SendKeys("testwise");
        driver.FindElement(By.Name("password")).Submit();
        Assert.IsTrue(driver.PageSource.Contains("Signed in!"));
    }

    [TestMethod]
    public void TestLoginFailed()
    {
        driver.FindElement(By.Name("username")).SendKeys("agileway");
        driver.FindElement(By.Name("password")).SendKeys("badpass");
        driver.FindElement(By.Name("password")).Submit();
        Assert.IsTrue(driver.PageSource.Contains("Invalid email or password"));
    }
}