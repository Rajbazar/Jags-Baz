Feature: About
  As a Velocity app user
  I would like to verify Terms and condition and other links
  So that I can able to use the app 

  @Android @IOS @Velocity-200
  Scenario: Verify App Version
    Given I am on Velocity app
    Given user is Logged in Velocity app
     And I tap on MainMenu
     And I wait for 3 seconds
     And I tap on About
     And Display text in AppVersion
  
  @Android @IOS @Velocity-201
  Scenario: Selenium Test
  Given Chrome is launched
  And Open Url
  And Enter PIN
  And Close Chrome


        






      
  