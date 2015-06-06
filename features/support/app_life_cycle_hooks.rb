if $Configuration["S1DeviceType"] == "IOS" || $Configuration["S2DeviceType"] == "IOS"
else
require 'calabash-android/management/adb'
require 'calabash-android/operations'
#require 'calabash-android/management/app_installation'
#require 'calabash-android/management/app_installation'

Before do |scenario|
 begin
/set_default_device($session["S1"])
  shutdown_test_server
  start_test_server_in_background
  set_default_device($session["S2"])
  shutdown_test_server
  start_test_server_in_background/
 rescue
end
end

After do |scenario|

 if scenario.failed?
    screenshot_embed
  end
  /set_default_device($session["S1"])	
  shutdown_test_server
   set_default_device($session["S2"])	
  shutdown_test_server/
end
end


