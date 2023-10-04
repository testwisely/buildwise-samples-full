package pages;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;

public class AbstractPage {

    protected WebDriver driver;

    public AbstractPage(WebDriver aDriver) {
        driver = aDriver;
    }

    public String getText(){
        return driver.findElement(By.tagName("body")).getText();
    }

    public String getFlashNoticeText() {
        return driver.findElement(By.id("flash_notice")).getText();
    }

    public void sleep(double seconds) {
        try {
            Thread.sleep((int) seconds * 1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

}
