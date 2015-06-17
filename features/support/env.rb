require 'selenium-webdriver' 
Selenium::WebDriver::Chrome.driver_path = './chromedriver' 
$wait = Selenium::WebDriver::Wait.new(:timeout => 20)
