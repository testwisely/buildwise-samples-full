package pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.support.ui.Select;

public class FlightPage extends AbstractPage {

    public FlightPage(WebDriver aDriver) {
        super(aDriver);
    }
    

    public void selectTripType(String trip_type) {
      driver.findElement(By.xpath("//input[@name='tripType' and @value='" + trip_type + "']")).click();
    }

    public void selectDepartFrom(String from_port) {
      Select select = new Select(driver.findElement(By.name("fromPort")));
      select.selectByVisibleText(from_port);
    }

    public void selectArriveAt(String to_port) {
      Select select = new Select(driver.findElement(By.name("toPort")));
      select.selectByVisibleText(to_port);
    }

    public void selectDepartDay(String depart_day) {
      Select select = new Select(driver.findElement(By.id("departDay")));
      select.selectByVisibleText(depart_day);
    }

    public void selectDepartMonth(String depart_month) {
      Select select = new Select(driver.findElement(By.id("departMonth")));
      select.selectByVisibleText(depart_month);
    }

    public void selectReturnDay(String return_day) {
      Select select = new Select(driver.findElement(By.id("returnDay")));
      select.selectByVisibleText(return_day);
    }

    public void selectReturnMonth(String return_month) {
      Select select = new Select(driver.findElement(By.id("returnMonth")));
      select.selectByVisibleText(return_month);
    }
    
    public void clickContinue() {
      driver.findElement(By.xpath("//input[@value='Continue']")).click();
    }
                      
  }
