if $Configuration["S1DeviceType"] == "IOS" || $Configuration["S2DeviceType"] == "IOS"
  require 'calabash-cucumber/calabash_steps'
else
  require 'calabash-android/calabash_steps'
end

##Given Session S1. I tap on LeftMenu
Then(/^I tap on ([\w ,'&]+)$/) do |ops|
session="S1"
  if $Configuration[session+"DeviceType"] == "Android"
        set_default_device($session[session])
        sleep 3
        if ops == "SIGN UP"
            tap_mark "butSignUp"
        elsif ops == "next"
            tap_mark "nextArrow"
        elsif ops == "LoginButton"
            tap_mark "butLogin"
        elsif ops == "MainMenu"
          tap_mark 'Open'
        elsif ops == "AddCardButton"
          tap_mark 'butPaymentMethAdd'
        elsif ops == "FirstReceipt"
          touch(query("* id:'tvVenueName'")[0])
        elsif ops == "StarButton"
          if element_exists("* text:'SKIP'")
            tap_mark 'SKIP'
            sleep 2
          end
          tap_mark 'butFavAnimator'
        elsif ops == "Settings"
          touch("* {text CONTAINS 'SETTINGS'}")
        elsif ops == "Account"
          touch("* {text CONTAINS 'ACCOUNT'}")
        elsif ops == "Receipts"
          tap_mark 'RECEIPTS'
        elsif ops == "DELETE ACCOUNT"
          tap_mark 'Delete Account'
        elsif ops == "Start a new Table"
          tap_mark 'butNewTable'
        elsif ops == "CUSTOM"
        begin
        wait_for_element_exists("* id:'butPay'")
        tap_mark 'butPay'
        rescue  
        end
        sleep 2
        tap_mark 'CUSTOM'
        else
           tap_mark "#{ops.to_s}"
        end
  else
    ios_connect(session)
    sleep 2
    if ops == "SIGN UP"
      tap_mark "SIGN UP"
        elsif ops == "next"
        elsif ops == "LoginButton"
          tap_mark "LOG IN"
        elsif ops == "MainMenu"
          tap_mark 'btnMenu'
        elsif ops == "About"
          touch("* {text CONTAINS 'ABOUT'}")
        elsif ops == "Settings"
          touch("* {text CONTAINS 'SETTINGS'}")
        elsif ops == "Start a new Table"
          tap_mark "START A NEW CHECK"
        elsif ops == "Account"
          touch("* {text CONTAINS 'ACCOUNT'}")
        elsif ops == "Wallet"
          tap_mark 'WALLET'
        elsif ops == "AddCardButton"
          tap_mark 'btnAddCard'
        elsif ops == "Receipts"
          tap_mark 'RECEIPTS'
        elsif ops == "FirstReceipt"
          touch(query("view")[0])
        elsif ops == "Discover"
          tap_mark 'DISCOVER'
        elsif ops == "StarButton"
          if element_exists("* text:'SKIP'")
            tap_mark 'SKIP'
            sleep 2
          end
          tap_mark 'btnFav'
        elsif ops == "Favourites"
          touch("* {text CONTAINS 'FAVOURITES'}")
        elsif ops == "CUSTOM"
          begin
            tap_mark 'down'
            sleep 5
         rescue 
         end
            sleep 2
          tap_mark 'CUSTOM'
        else
           tap_mark "#{ops.to_s}"
           sleep 2
            if element_exists("* text:'YOUR LOCATION'")
              tap_mark 'btnLocation'
              sleep 2
              tap_mark 'SKIP'
              sleep 2
            end 
        end
end
end

##Sample Code
Then(/^I am on Velocity app$/) do
session="S1"
  if $Configuration[session+"DeviceType"] == "Android"
        set_default_device($session[session])
        sleep 2
  else
    ios_connect(session)
    start_test_server_in_background
    sleep 5
end
end

## Clear data on Android 
Then(/^Clear app data$/) do 
session="S1"
    if $Configuration[session+"DeviceType"] == "Android"
        set_default_device($session[session])
        sleep 2
        clear_app_data
        sleep 2
        start_test_server_in_background()
    else
      ios_connect(session)
      sleep 2
    if element_exists("* text:'SKIP'")
      tap_mark 'SKIP'
      sleep 2
    end
    if element_does_not_exist("* text:'SIGN UP'")
      tap_mark 'btnMenu'
      sleep 2
      touch("* {text CONTAINS 'SETTINGS'}")
      sleep 2
      tap_mark 'LOGOUT'
      sleep 2
      tap_mark 'Yes'
      sleep 2
    end
    end
end               
##And Verify signup screen
Then(/^Verify ([\w ]+)$/) do |verifyText|
session="S1"
    if $Configuration[session+"DeviceType"] == "Android"
        set_default_device($session[session])
        sleep 2
        if verifyText == "signup screen"
                 begin
                 wait_for_element_exists("* text:'CREATE NEW ACCOUNT'")
                 puts "Element Found"
                 rescue
                 screenshot_and_raise('Text Not Found')
                 end
        elsif verifyText == "Login successful popup"
        begin
         wait_for_element_exists("* text:'Logged in Successfully'")
         puts "Element Found"
        rescue
          screenshot_and_raise('Text Not Found')
        end
        elsif verifyText == "Incorrect details popup"
            begin
                 wait_for_element_exists("* text:'Incorrect login details, please try again'")
                 tap_mark "Close"
            rescue
                 screenshot_and_raise('Text Not Found')
            end
        elsif verifyText == "Payment Methods"
          begin
                 wait_for_element_exists("* text:'Payment Methods'")
            rescue
                 screenshot_and_raise('Text Not Found')
            end
          elsif verifyText == "Favourites listings"
             if query("* id:'ivVenueImage'").count == 2 
              puts "Pass: Element Found"
              touch(query("* id:'ivVenueImage'")[0])
              sleep 2
              tap_mark 'butFavAnimator'
              sleep 2
              system("#{default_device.adb_command} shell input keyevent KEYCODE_BACK")
              sleep 2
              touch(query("* id:'ivVenueImage'")[0])
              sleep 2
              tap_mark 'butFavAnimator'
              sleep 2
              system("#{default_device.adb_command} shell input keyevent KEYCODE_BACK")
            else
              fail('Element not found')
            end
          elsif verifyText == "EmailReceiptPopup"
              begin
                 wait_for_element_exists("* {text CONTAINS 'receipt has been sent'}")
                 puts 'Element found'
            rescue
                 screenshot_and_raise('Text Not Found')
            end
        else
        end
    else
        ios_connect(session)
        sleep 2
        if verifyText == "signup screen"
                 begin
                 wait_for_element_exists("* text:'CREATE NEW ACCOUNT'")
                 puts "Element Found"
                 rescue
                 screenshot_and_raise('Text Not Found')
                 end
        elsif verifyText == "Login successful"
          begin
          wait_for_element_exists("* {text CONTAINS 'VENUES'}")
          puts "Element Found"
          sleep 2
          tap_mark "SKIP"
          rescue
            screenshot_and_raise('Text Not Found')
          end
        elsif verifyText == "Incorrect details popup"
           begin
                 wait_for_element_exists("* text:'Incorrect login details, please try again'")
                 tap_mark "OK"
                 puts "Element Found"
            rescue
                 screenshot_and_raise('Text Not Found')
            end 
        elsif verifyText == "Favourites listings"
          if query("* id:'btnFavBig'").count == 1
            fail('Element not found')
            else
            puts "Pass: Element Found"
             touch("UIImageView")
             sleep 3
             if element_exists("* id:'btnFavOn'")
              tap_mark 'btnFavOn'
            end
          end
        elsif verifyText == "EmailReceiptPopup"
              begin
                 wait_for_element_exists("* {text CONTAINS 'receipt has been sent'}")
                 puts 'Element found'
                 tap_mark 'OK'
            rescue
                 screenshot_and_raise('Text Not Found')
            end
        else
        end
    end
end

##And I enter mailid
Then(/^I enter ([\w ]+)$/) do |ops|
session="S1"
    if $Configuration[session+"DeviceType"] == "Android"
      set_default_device($session[session])
      sleep 3
      if ops == "Email"
        tap_mark 'etEmail'
        keyboard_enter_text "#{$Configuration["UserEmail"]}"
        sleep 2
      end
      if ops == "Password" || ops == "PASSWORD"
        tap_mark 'etPassword'
        keyboard_enter_text "#{$Configuration["UserPassword"]}"
        sleep 2
      end
      if ops == "IncorrectPassword"
        tap_mark 'etPassword'
        keyboard_enter_text "abcd123456"
        sleep 2
      end
      if ops == "FirstName"
        if element_exists("* {text CONTAINS 'already in use'}")
            fail('Email already in use')
        end
        tap_mark 'etFirstName'
        keyboard_enter_text "#{$Configuration["FirstName"]}"
        sleep 2
      end
      if ops == "LastName"
        if element_exists("* {text CONTAINS 'already in use'}")
            fail('Email already in use')
        end
        tap_mark 'etSurname'
        keyboard_enter_text "#{$Configuration["LastName"]}"
        sleep 2
     end
      if ops == "MobileNumber"
        if element_exists("* {text CONTAINS 'already in use'}")
            fail('Email already in use')
        end
        tap_mark 'etMobile'
        keyboard_enter_text "#{$Configuration["MobileNumber"]}"
        sleep 2
      end
    else
    ios_connect(session)
    sleep 2
    if ops == "Email"
      touch(query("* UITextField")[0])
      wait_for_keyboard
      keyboard_enter_text("#{$Configuration["UserEmail"]}")
      sleep 2
      end
      if ops == "Password"
      touch(query("* UITextField")[2])
      wait_for_keyboard
      keyboard_enter_text("#{$Configuration["UserPassword"]}")
      sleep 2
      end
      if ops == "PASSWORD"
      touch(query("* UITextField")[1])
      wait_for_keyboard
      keyboard_enter_text("#{$Configuration["UserPassword"]}")
      sleep 2
      end
      if ops == "IncorrectPassword"
      touch(query("* UITextField")[1]) 
      wait_for_keyboard 
      keyboard_enter_text("musop123456")
      end
      if ops == "FirstName"
      touch(query("* UITextField")[0])
      wait_for_keyboard
      keyboard_enter_text("#{$Configuration["FirstName"]}")
      sleep 2
      end
      if ops == "LastName"
      touch(query("* UITextField")[1])
      wait_for_keyboard
      keyboard_enter_text("#{$Configuration["LastName"]}")
      sleep 2
      end
      if ops == "MobileNumber"
      touch(query("* UITextField")[1])
      wait_for_keyboard
      keyboard_enter_text("#{$Configuration["MobileNumber"]}")
      sleep 2
      end
    end
end

##Change settings for DEV Server
Then(/^Change settings for ([\w ]+)$/) do |settings|
  session="S1"
    if $Configuration[session+"DeviceType"] == "Android"
      set_default_device($session[session])
      sleep 3
      tap_mark 'etEmail'
      keyboard_enter_text "#12349"
      perform_action('press_user_action_button', 'next')
      sleep 2
      tap_mark "#{settings}"
      sleep 2
      tap_mark 'butUpdateServer'
      sleep 2
      tap_mark 'Yes'
      start_test_server_in_background
      sleep 5
    else
      ios_connect(session)
      sleep 2
      touch(query("* UITextField")[0])
      wait_for_keyboard
      keyboard_enter_text("#12349")
      tap_mark "NEXT"
      sleep 4
      tap_mark "#{settings}"
      sleep 2
      begin
      tap_mark "OK"
      tap_mark "OK"
      sleep 2
      rescue
      end
      shutdown_test_server
      sleep 2
      start_test_server_in_background
    end
end

##Given user is Logged in Velocity app
Then(/^user is Logged in Velocity app$/) do
  session="S1"
    if $Configuration[session+"DeviceType"] == "Android"
      set_default_device($session[session])
      sleep 5
      if element_exists("* text:'Venues'")
        puts "Element Found"
      else
        fail('User not logged in.')
      end
    else
      ios_connect(session)
      sleep 5
      if element_exists("* text:'VENUES'")
        puts "Element Found"
      else
        fail('User not logged in.')
      end
    end  
end

##And Display AppVersion
Then(/^Display text in ([\w ]+)$/) do |ops|
  session="S1"
  if $Configuration[session+"DeviceType"] == "Android"
      set_default_device($session[session])
      sleep 3
      if ops == "AppVersion"
        puts "App Version: " + query("* id:'tvVersion'",:text)[0].to_s
      else
      end       
  else
    ios_connect(session)
    sleep 3
    if ops == "AppVersion"
        puts "App Version: " + query("UILabel", :text)[5].to_s
      else
      end 
  end  
end

Then(/^Chrome is launched/) do
$driver = Selenium::WebDriver.for :chrome, :switches => %w[--ignore-certificate-errors --disable-popup-blocking --disable-translate]
end

Then(/^Open Url$/) do
  $driver.navigate.to "#{$Configuration["URL"]}"
  $driver.manage.window.maximize
  sleep 15
end

Then(/^Enter PIN$/) do
$driver.find_element(:id, "password").clear
$driver.find_element(:xpath, "//button["+$Configuration["WebPIN"][0]+"]").click
$driver.find_element(:xpath, "//button["+$Configuration["WebPIN"][1]+"]").click
$driver.find_element(:xpath, "//button["+$Configuration["WebPIN"][2]+"]").click
$driver.find_element(:xpath, "//button["+$Configuration["WebPIN"][3]+"]").click
sleep 5
end

Then(/^Close Chrome$/) do
  $driver.quit
  puts "Closed"
end

Then(/^I scroll to ([\w ]+)$/) do |ops|
  session="S1"
  if $Configuration[session+"DeviceType"] == "Android"
      set_default_device($session[session])
      sleep 3 
      if ops == "right"
        perform_action('swipe', 'right')
        elsif ops == "left" 
        perform_action('swipe', 'left')
      end
  else
    ios_connect(session)
    sleep 3
  end  
end

Then(/^I scroll venue to right$/) do
  session="S1"
  if $Configuration[session+"DeviceType"] == "Android"
      set_default_device($session[session])
      sleep 3 
      perform_action('drag', 90, 0, 50, 50, 50)
  else
    ios_connect(session)
    sleep 3
    swipe :right, force: :strong
  end  
end
