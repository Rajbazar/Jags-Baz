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
            system("#{default_device.adb_command} shell input keyevent KEYCODE_ENTER")
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
    if element_does_not_exist("* text:'SIGN UP'")
      tap_mark 'btnMenu'
      sleep 2
      tap_mark 'VIEW ACCOUNT'
      sleep 2
      tap_mark 'EDIT ACCOUNT DETAILS'
      sleep 2
      tap_mark 'btnLogout'
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
                 wait_for_element_exists("* text:'REGISTRATION'")
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
                 wait_for_element_exists("* text:'Incorrect username and password'")
                 tap_mark "Close"
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
        query("* id:'etRegisterInfo'", {:setText => ""})
        query("* id:'etRegisterInfo'", {:setText => "#{$Configuration["UserEmail"]}"})
      end
      if ops == "Password"
        query("* id:'etRegisterInfo'", {:setText => ""})
        query("* id:'etRegisterInfo'", {:setText => "#{$Configuration["UserPassword"]}"})
      end
      if ops == "IncorrectPassword"
        query("* id:'etRegisterInfo'", {:setText => ""})
        query("* id:'etRegisterInfo'", {:setText => "abcd123456"})
      end
      if ops == "FirstName"
        if element_exists("* {text CONTAINS 'already in use'}")
            fail('Email already in use')
        end
        query("* id:'etRegisterNameInfo'", {:setText => ""})
        query("* id:'etRegisterNameInfo'", {:setText => "#{$Configuration["FirstName"]}"})
      end
      if ops == "LastName"
        if element_exists("* {text CONTAINS 'already in use'}")
            fail('Email already in use')
        end
        query("* id:'etBasicInfo'", {:setText => ""})
        query("* id:'etBasicInfo'", {:setText => "#{$Configuration["LastName"]}"})
     end
      if ops == "MobileNumber"
        if element_exists("* {text CONTAINS 'already in use'}")
            fail('Email already in use')
        end
        query("* id:'etRegisterNameInfo'", {:setText => ""})
        query("* id:'etRegisterNameInfo'", {:setText => "#{$Configuration["MobileNumber"]}"})
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
      query("* id:'etRegisterInfo'", {:setText => ""})
      query("* id:'etRegisterInfo'", {:setText => "#12349"})
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
  end  
end