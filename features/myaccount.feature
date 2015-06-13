Feature: My Account
    As a first time Velocity app user
    I want to create my account with velocity
    So that I can able to navigate the app

  @Android @Velocity-100
  Scenario: To create an account as a new user
    Given I am on Velocity app
     When I tap on SIGN UP
      And Verify signup screen
      And I enter Email
      And I tap on next
      And I enter Password
      And I tap on next
      And I enter Password
      And I tap on next
      And I enter FirstName
      And I enter LastName
      And I tap on next
      And I tap on next
     Then I enter MobileNumber
      And I tap on next
      And I tap on next

@IOS @Velocity-1100
  Scenario: To create an account as a new user
    Given I am on Velocity app
     When I tap on SIGN UP
      And Verify signup screen
      And I enter Email
      Then I enter MobileNumber
      And I enter Password
      And I tap on NEXT
      And I enter FirstName
      And I enter LastName
      And I tap on NEXT
      And I wait for 10 seconds
      And I tap on SKIP

@Android @Velocity-101
  Scenario: Test successful login
  Given I am on Velocity app
   Then Clear app data
   When I tap on LoginButton
   Then Change settings for DEV Server
    And I tap on LoginButton
    And I enter Email
    And I tap on next
    And I enter Password
    And I tap on next
   Then Verify Login successful popup

@IOS @Velocity-1101
  Scenario: Test successful login
  Given I am on Velocity app
   Then Clear app data
   When I tap on LoginButton
   Then Change settings for DEVELOPMENT
    And I tap on LoginButton
    And I enter Email
    And I enter PASSWORD
    And I tap on NEXT
   Then Verify Login successful 

@Android @Velocity-102
  Scenario: Unsuccessful Login with username and wrong password
  Given I am on Velocity app
    Then Clear app data
     When I tap on LoginButton
      Then Change settings for DEV Server
      And I tap on LoginButton
      And I enter Email
      And I tap on next
      And I enter IncorrectPassword
      And I tap on next
     Then Verify Incorrect details popup


@IOS @Velocity-1102
  Scenario: Unsuccessful Login with username and wrong password
  Given I am on Velocity app
    Then Clear app data
     When I tap on LoginButton
      Then Change settings for DEVELOPMENT
      And I tap on LoginButton
      And I enter Email
      And I enter IncorrectPassword
      And I tap on NEXT
     Then Verify Incorrect details popup
      And I tap on BACK

    

    
 



        






      
  