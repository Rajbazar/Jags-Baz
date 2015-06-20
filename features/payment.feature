Feature: Payment
  As a Velocity app user
  I would like to check my recipt on the app
  So that I can able to pay  

  @Android @Velocity-300
  Scenario: Verify total bill on app and web
    Given I am on Velocity app
    Given user is Logged in Velocity app
    And I select venue as AMIKA
    Given Chrome is launched
    And Open Url
    And Enter PIN
    Then select table number 5
    Then I add Breakfast item
    Then I tap on Start a new bill
    And I should be able to see my bill on app
    And Complete Payment Process
    And Close Chrome


  @Android @Velocity-301
  Scenario: updating and verifying the card details
      Given I am on Velocity app
      Given user is Logged in Velocity app
      And I tap on MainMenu
      And I wait for 3 seconds
      Then I tap on Wallet
      And I wait for 5 seconds
      And Verify Payment Methods
      When I tap on AddCardButton
      And I enter my card-details  
      Then Delete my card-details
        






      
  