

Then(/^I select venue as ([\w ]+)$/) do |ops|
session="S1"
    if $Configuration[session+"DeviceType"] == "Android"
        set_default_device($session[session])
        sleep 2
        var=query("* id:'ivVenueImage'").to_s
    exp=/. ([\d,-]+) #/
    m=exp.match(var)
    coord=m.captures[0]
    act_coord=coord.split("-")[1]
    x_coord=act_coord.split(",")[0].to_i
    y_coord=act_coord.split(",")[1].to_i
    if element_does_not_exist("* text:'"+ops.to_s+"'")
    i=0
    while i < 20
      system("#{default_device.adb_command} shell input swipe #{x_coord} #{y_coord} #{x_coord} #{y_coord-200}")
      sleep 2
      if element_exists("* text:'"+ops.to_s+"'")
        tap_mark "#{ops.to_s}"
        break
      end
  end
  else
    tap_mark "#{ops.to_s}"
  end
    else
      ios_connect(session)
      sleep 2
    end
end

##Then select table number 5
Then(/^select table number ([\d]+)$/) do |number|
  $driver.find_element(:xpath, "//div["+number.to_s+"]").click
  sleep 2
  $driver.find_element(:css, "a.accordion-toggle > span.ng-binding").click
end

##Then I add breakfast item
Then(/^I add ([\w]+) item$/) do |list_item|
  if list_item == "Breakfast"
    $driver.find_element(:css, "a.accordion-toggle > span.ng-binding").click
    sleep 2
    $driver.find_element(:css, "h5.col-tab-50.ng-binding").click
    sleep 2
    $driver.find_element(:css, "a.accordion-toggle > span.ng-binding").click
  elsif list_item == "Lunch"
    $driver.find_element(:xpath, "//div[2]/div/h4/a/span").click
    sleep 2
    $driver.find_element(:xpath, "//div[2]/div[2]/div/div/h5").click
    sleep 2
    $driver.find_element(:xpath, "//div[2]/div/h4/a/span").click
  elsif list_item == "Dinner"
    $driver.find_element(:css, "span.ng-scope").click
    sleep 2
    $driver.find_element(:xpath, "//div[3]/div[2]/div/div[3]/h5").click
    sleep 2
    $driver.find_element(:css, "span.ng-scope").click
  elsif list_item == "Drinks"
    $driver.find_element(:xpath, "//div[4]/div/h4/a/span").click 
    sleep 2
    $driver.find_element(:xpath, "//div[4]/div[2]/div/div/h5").click
    sleep 2
    $driver.find_element(:xpath, "//div[4]/div/h4/a/span").click 
end
end


##And I should be able to see my bill
Then(/^I should be able to see my bill on app$/) do 
  total_web_bill=$driver.find_element(:xpath, "/html/body/div[4]/div/div/div[2]/div[1]/div[2]/h5[2]").text
  puts "Web --> " + total_web_bill.to_s
  sleep 2
  bill_float=total_web_bill.gsub(/TOTAL: £/,'').to_f
  sleep 2
  $driver.find_element(:css, "button.btn.velocity").click
  $wait.until { $driver.find_element(:css => "h5.col-tab-20.ng-binding").displayed? }
  $driver.find_element(:css, "h5.col-tab-20.ng-binding").click
  session="S1"
    if $Configuration[session+"DeviceType"] == "Android"
        set_default_device($session[session])
        sleep 2
        wait_for_element_exists("* id:'tvBillTotal'")
        sleep 7
        app_bill=query("* id:'tvBillTotal'", :text)[0]
        puts "App --> " + app_bill.to_s
        app_bill=app_bill.gsub(/£/,'').to_f
        if app_bill == bill_float
          puts "Bills matched on both app and web!!"
        else
          fail('Bills not matched')
        end  
    else
      ios_connect(session)
      sleep 2
  end
end

##And Complete Payment Process
Then(/^Complete Payment Process$/) do 
  session="S1"
    if $Configuration[session+"DeviceType"] == "Android"
        set_default_device($session[session])
        sleep 2
        wait_for_element_exists("* id:'butPay'")
        tap_mark 'butPay'
        wait_for_element_exists("* id:'butPayBill'")
        tap_mark 'butPayBill'
        sleep 10
        wait_for_element_exists("* id:'butConfirmPayment'")
        tap_mark 'butConfirmPayment'
        wait_for_element_exists("* id:'rbRating'")
        tap_mark 'rbRating'
        wait_for_element_exists("* id:'butConfirm'")
        tap_mark 'butConfirm'
        wait_for_element_exists("* id:'butCloseThankYou'")
        tap_mark 'butCloseThankYou'
    else
      ios_connect(session)
      sleep 2
end
end


