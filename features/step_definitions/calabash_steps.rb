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
        else
           tap_mark "#{ops.to_s}"
        end
  else
    ios_connect(session)
end
end

##Sample Code
Then(/^I am on Velocity app$/) do
session="S1"
  if $Configuration[session+"DeviceType"] == "Android"
        set_default_device($session[session])
        sleep 2
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
    end
end