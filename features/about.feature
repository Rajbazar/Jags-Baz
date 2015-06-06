Feature: About
  As a Velocity app user
  I would like to verify Terms and condition and other links
  So that I can able to use the app 

  @Android @Velocity-200
  Scenario: Verify App Version
    Given user is Logged in Velocity app
     And I tap on MainMenu
     And I wait for 3 seconds
     And I tap on About
     And Display text in AppVersion
  


        






      
  