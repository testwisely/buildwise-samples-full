package tests;

import org.junit.*;
import org.junit.Assert.*;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

import pages.*;

public class FlightTest {
    static WebDriver driver;

    @BeforeClass
    public static void setUp() throws Exception {
        driver = new ChromeDriver();
        driver.get("https://travel.agileway.net");
        
        LoginPage loginPage = new LoginPage(driver);
        loginPage.enterUsername("agileway");
        loginPage.enterPassword("testwise");
        loginPage.clickSignIn();
    }

    @AfterClass
    public static void tearDown() {
        driver.quit();
    }

    @Test
    public void testOneWayTrip() {
        FlightPage loginPage = new FlightPage(driver);
        
    }


}