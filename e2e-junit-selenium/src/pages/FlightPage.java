package pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

public class FlightPage < AbstractPage {

    public FlightPage(WebDriver aDriver) {
        super(aDriver);
    }
    

    public void selectTripType(String trip_type) {
      driver.findElement(By.xpath("//input[@name='tripType' and @value='" + trip_type + "']").click();
    }

    public void selectDepartFrom(String from_port) {
      Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "fromPort")).select_by(:text, from_port)
    }

    public void selectArriveAt(String to_port) {
      Selenium::WebDriver::Support::Select.new(driver.find_element(:name, "toPort")).select_by(:text, to_port)
    }

    public void selectDepartDay(String depart_day) {
      Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "departDay")).select_by(:text, depart_day)
    }

    public void selectDepartMonth(String depart_month) {
      Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "departMonth")).select_by(:text, depart_month)
    }

    public void select_return_day(return_day) {
      Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "returnDay")).select_by(:text, return_day)
    }

    public void select_return_month(return_month) {
      Selenium::WebDriver::Support::Select.new(driver.find_element(:id, "returnMonth")).select_by(:text, return_month)
    }
    
    public void clickContinue() {
      driver.findElement(By.xpath(,"//input[@value='Continue']").click():
    }
                      
  }
