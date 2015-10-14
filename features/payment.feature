Feature: Payment
  As a Velocity app user
  I would like to check my recipt on the app
  So that I can able to pay  

  @Android @IOS @Velocity-300
  Scenario: Verify total bill on app and web (with tip)
    Given I am on Velocity app
    Given user is Logged in Velocity app
    And I select venue as AMIKA
    Given Chrome is launched
    And Open Url
    And Login Amika
    Then select table number 5
    Then I add Breakfast item
    Then I tap on Start a new Table
    And I should be able to see my bill on app
    Then I tap on CUSTOM
    Then I enter tip-amount as 5
    And Complete Payment Process
    And Close Chrome

@IOS @Velocity-330
  Scenario: Verify total bill on app and web (with tip)
    Given I am on Velocity app
    Given user is Logged in Velocity app
    And I select venue as AMIKA
    Given Chrome is launched
    And Open Url
    And Enter PIN
    Then select table number 5
    Then I add Breakfast item
    Then I tap on Start a new Table
    And I should be able to see my bill on app
    And Complete Payment Process
    And Close Chrome

  @Android @Velocity-301
  Scenario: updating and verifying the card details
      Given I am on Velocity app
      Given user is Logged in Velocity app
      And I tap on MainMenu
      And I wait for 3 seconds
      Then I tap on Account
      And I wait for 2 seconds
      Then I tap on WALLET
      And I wait for 5 seconds
      And Verify Payment Methods
      When I tap on AddCardButton
      And I enter my card-details  
      Then Delete my card-details

@IOS @Velocity-1301
  Scenario: updating and verifying the card details
      Given I am on Velocity app
      Given user is Logged in Velocity app
      And I tap on MainMenu
      And I wait for 3 seconds
      Then I tap on Account
      And I wait for 3 seconds
      Then I tap on Wallet
      And I wait for 5 seconds
      And Verify Payment Methods
      When I tap on AddCardButton
      And I enter my card-details  
      Then Delete my card-details
        
@Android @Velocity-302
  Scenario: Verify and manage to see the recipt listings for recent visits
    Given I am on Velocity app
    Given user is Logged in Velocity app
    And I tap on MainMenu
    And I wait for 3 seconds
    Then I tap on Account
    And I wait for 2 seconds
    When I tap on Receipts
    And I wait for 5 seconds
    Then I should able to see the list of RECENT VISITS
    And I tap on FirstReceipt

@Android @Velocity-304
  Scenario: Send receipts over mail
    Given I am on Velocity app
    Given user is Logged in Velocity app
    And I tap on MainMenu
    And I wait for 3 seconds
    Then I tap on Account
    And I wait for 2 seconds
    When I tap on Receipts
    And I wait for 5 seconds
    Then I should able to see the list of RECENT VISITS
    And I tap on FirstReceipt
    And I tap on Request Email Receipt
    Then Verify EmailReceiptPopup 

@IOS @Velocity-1302
  Scenario: Verify and manage to see the recipt listings for recent visits
    Given I am on Velocity app
    Given user is Logged in Velocity app
    And I tap on MainMenu
    And I wait for 3 seconds
    Then I tap on Account
    And I wait for 3 seconds
    When I tap on Receipts
    And I wait for 5 seconds
    Then I should able to see the list of RECENT VISITS
    And I tap on FirstReceipt

@IOS @Velocity-1304
  Scenario: Verify and manage to see the recipt listings for recent visits
    Given I am on Velocity app
    Given user is Logged in Velocity app
    And I tap on MainMenu
    And I wait for 3 seconds
    Then I tap on Account
    And I wait for 3 seconds
    When I tap on Receipts
    And I wait for 5 seconds
    Then I should able to see the list of RECENT VISITS
    And I tap on FirstReceipt
    And I tap on REQUEST EMAIL RECEIPT
    Then Verify EmailReceiptPopup 


@Android @Velocity-303
  Scenario: Adding the Venues onto my favourite lists
    Given I am on Velocity app
    Given user is Logged in Velocity app
     When I tap on Discover
     Then I tap on StarButton
      And I scroll venue to right
      And I tap on StarButton
      And I tap on MainMenu
      And I wait for 3 seconds
      And I tap on Favourites
      And I wait for 5 seconds
      And Verify Favourites listings    

@IOS @Velocity-1303
  Scenario: Adding the Venues onto my favourite lists
    Given I am on Velocity app
    Given user is Logged in Velocity app
     When I tap on Discover
     Then I tap on StarButton
      And I tap on MainMenu
      And I wait for 3 seconds
      And I tap on Favourites
      And I wait for 5 seconds
      And Verify Favourites listings            
  

  @IOS @Android @Velocity-1305
  Scenario: Payment flow after adding Concur ability to add expense memo and Expense code
    Given I am on Velocity app
    Given user is Logged in Velocity app
    And I select venue as AMIKA
    Given Chrome is launched
    And Open Url
    And Login Amika
    Then select table number 5
    Then I add Breakfast item
    Then I tap on Start a new Table
    And I should be able to see my bill on app
    And Complete Payment Process with Concur
    And Close Chrome


  @IOS @Android @Velocity-1306
  Scenario: Payment using concur from previous receipts
    Given I am on Velocity app
    And I wait for 5 seconds
    And I tap on MainMenu
    And I wait for 3 seconds
    Then I tap on Account
    And I wait for 2 seconds
    When I tap on Receipts
    And I wait for 5 seconds
    And I tap on FirstReceipt
    And I wait for 2 seconds
    And pay using Concur

