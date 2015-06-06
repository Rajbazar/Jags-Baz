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

  @Android @Velocity-101
  Scenario: Test successful login
    Given I am on Velocity app
     When I tap on LoginButton
      And I enter Email
      And I tap on next
      And I enter Password
      And I tap on next
    Then Verify Login successful popup

  @Android @Velocity-102
  Scenario: Unsuccessful Login with username and wrong password
    Then Clear app data
    Given I am on Velocity app
     When I tap on LoginButton
      And I enter Email
      And I tap on next
      And I enter IncorrectPassword
      And I tap on next
     Then Verify Incorrect details popup
     


@Android @Velocity-103
Scenario: Rest the password by retreving pin number
   Given I am on Velocity app
    When I tap on LoginButton
     And I enter Email
     And I tap on next
    When I tap on ForgotPassword
     And I wait for 5 seconds
    Then I should see Verify Code screen
     And I Entercode 
     And I enter Password
    Then Verify Login successful popup    


 @Android @Velocity-104 
  Scenario: Login using Facebook account
   Given I am on Velocity app
     And I tap on Login
     And I tap on Log in with Facebook
    Then Verify login is successful
    
 



        






      
  