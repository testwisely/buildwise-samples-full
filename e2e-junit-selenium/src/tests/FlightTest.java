package tests;

import org.junit.*;
import org.junit.Assert.*;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;

import helper.TestHelper;
import pages.*;

public class FlightTest {
    static WebDriver driver;

    @BeforeClass
    public static void beforeAll() throws Exception {
        driver = new ChromeDriver();
        driver.get(TestHelper.siteUrl());
        
        LoginPage loginPage = new LoginPage(driver);
        loginPage.enterUsername("agileway");
        loginPage.enterPassword("testwise");
        loginPage.clickSignIn();
    }

    @AfterClass
    public static void afterAll() {
        driver.quit();
    }

    @Before
    public void beforeEach() {
        driver.get(TestHelper.siteUrl());
    }

    @Test
    public void testOneWayTrip() {
        FlightPage flightPage = new FlightPage(driver);
		flightPage.selectTripType("oneway");
        flightPage.selectDepartFrom("New York");
        flightPage.selectArriveAt("Sydney");
        flightPage.clickContinue();
        
    }

    @Test
    public void testReturnTrip() {
        FlightPage flightPage = new FlightPage(driver);
		flightPage.selectTripType("return");
        flightPage.selectDepartFrom("New York");
        flightPage.selectArriveAt("Sydney");
        flightPage.clickContinue();
        
    }


}