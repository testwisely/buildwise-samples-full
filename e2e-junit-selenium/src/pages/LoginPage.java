package pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

public class LoginPage < AbstractPage {

    public LoginPage(WebDriver aDriver) {
        super(aDriver);
    }

    public void enterUsername(String username) {
        driver.findElement(By.id("username")).clear();
        driver.findElement(By.id("username")).sendKeys(username);
    }

    public void enterPassword(String password) {
        driver.findElement(By.id("password")).clear();
        driver.findElement(By.id("password")).sendKeys(password);
    }

    public void clickSignIn() {
        driver.findElement(By.xpath("//input[@value='Sign in']")).click();
    }
}
