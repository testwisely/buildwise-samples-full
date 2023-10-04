package pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

public class PassengerPage extends AbstractPage {

    public PassengerPage(WebDriver aDriver) {
        super(aDriver);
    }

    public void enterFirstName(String firstName) {
        driver.findElement(By.name("passengerFirstName")).sendKeys(firstName);
    }

    public void enterLastName(String lastName) {
        driver.findElement(By.name("passengerLastName")).sendKeys(lastName);
    }

    public void clickNext() {
        driver.findElement(By.xpath("//input[@value='Next']")).click();
    }
}
