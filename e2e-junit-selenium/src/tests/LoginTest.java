package tests;

import org.junit.*;
import org.junit.Assert.*;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

import pages.*;

public class LoginTest {
    static WebDriver driver;

    @BeforeClass
    public static void setUp() throws Exception {
        driver = new ChromeDriver();
        driver.get("https://travel.agileway.net");
    }

    @AfterClass
    public static void tearDown() {
        driver.quit();
    }

    @Test
    public void testSignInFailed() {
        LoginPage loginPage = new LoginPage(driver);
        loginPage.enterUsername("agileway");
        loginPage.enterPassword("guess");
        loginPage.clickSignIn();
        Assert.assertEquals("Invalid email or password", driver.findElement(By.id("flash_alert1")).getText() ); 
    }

    @Test
    public void testSignInOK() {
        LoginPage loginPage = new LoginPage(driver);
        loginPage.enterUsername("agileway");
        loginPage.enterPassword("testwise");
        loginPage.clickSignIn();
        Assert.assertTrue( driver.findElement(By.tagName("body")).getText().contains("Signed in!") );
    }


}