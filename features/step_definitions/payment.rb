
def android_textgrep()
    arr=query("*", :text)
    act_arr=Array.new
    i=0
    while i<arr.length
      if arr[i]['error'] == nil
          act_arr.push(arr[i].to_s)
        else
      end
    i+=1
    end
    return act_arr
end
def p_arry(a)
    i=0
    while i<a.length
        puts a[i].to_s + "\n"
        i+=1
    end
end
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
      while element_does_not_exist("* text:'"+ops.to_s+"'")
        scroll("view", :down)
        sleep 2
      end
      touch("* text:'"+ops.to_s+"'")
    end
end

##Then select table number 5
Then(/^select table number ([\d]+)$/) do |number|
  $driver.find_element(:xpath, "//div["+number.to_s+"]").click
  sleep 2
  $driver.find_element(:css, "a.accordion-toggle > span.ng-binding").click
  sleep 2
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
    session="S1"
  if $Configuration[session+"DeviceType"] == "Android"
        set_default_device($session[session])
        sleep 5
        if element_exists("* text:'Yes'")
          touch("* text:'Yes'")
          sleep 2
        end
  else
    ios_connect(session)
    sleep 5
     if element_exists("* text:'Yes'") || element_exists("* text:'YES'")
          touch("* text:'Yes'")
          sleep 2
        end
  end
  sleep 5
  total_web_bill=$driver.find_element(:xpath, "/html/body/div[5]/div/div/div[2]/div[1]/div[2]/h5[2]").text
  puts "Web --> " + total_web_bill.to_s
  sleep 2
  bill_float=total_web_bill.gsub(/TOTAL: £/,'').to_f
  sleep 2
  $driver.find_element(:css, "button.btn.velocity").click
  $wait.until { $driver.find_element(:css => "h5.col-tab-20.ng-binding").displayed? }
  $driver.find_element(:css, "h5.col-tab-20.ng-binding").click
  sleep 7
    if $Configuration[session+"DeviceType"] == "Android"
        set_default_device($session[session])
        sleep 5
        wait_for_element_exists("* id:'butConfirmPayment'")
        tap_mark 'butConfirmPayment'
        sleep 15
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
      sleep 5
      tap_mark 'btnDone'
      sleep 15
      var = query("*", :text)
      i=0
      while (i<var.length)
        if (query("*", :text)[i] == "Paid:")
          app_bill=query("*", :text)[i+4]
          break
         else
          i+=1
        end 
      end
      puts "App --> " + app_bill.to_s
        app_bill=app_bill.gsub(/£/,'').to_f
        if app_bill == bill_float
          puts "Bills matched on both app and web!!"
        else
          fail('Bills not matched')
        end    
  end
end

##And Complete Payment Process
Then(/^Complete Payment Process$/) do 
  session="S1"
    if $Configuration[session+"DeviceType"] == "Android"
        set_default_device($session[session])
        sleep 2
        begin
        wait_for_element_exists("* id:'butPay'")
        tap_mark 'butPay'
        rescue  
        end
        wait_for_element_exists("* id:'butPayBill'")
        tap_mark 'butPayBill'
        sleep 10
        wait_for_element_exists("* id:'rbRating'")
        tap_mark 'rbRating'
        wait_for_element_exists("* id:'butConfirm'")
        tap_mark 'butConfirm'
        wait_for_element_exists("* id:'butCloseThankYou'")
        tap_mark 'butCloseThankYou'
    else
      ios_connect(session)
      sleep 5
      begin
          tap_mark 'down'
          sleep 5
      rescue 
      end
      tap_mark 'btnPay'
      sleep 5
      begin
          tap_mark 'Continue with no gratuity'
          sleep 2
      rescue 
      end
      sleep 15
      tap_mark '4 stars'
      sleep 2
      tap_mark 'btnDone'
      sleep 5
      tap_mark 'btnCloseMap'
end
end

##And I enter my card details  
Then(/^I enter my card-details$/) do 
  session="S1"
    if $Configuration[session+"DeviceType"] == "Android"
        set_default_device($session[session])
        sleep 2
        wait_for_element_exists("* id:'etCardNo'")
        enter_text("* id:'etCardNo'", "#{$Configuration["CardNo"]}")
        sleep 2
        enter_text("* id:'etExpiryDate'", "#{$Configuration["CardExpiry"]}")
        sleep 2
        enter_text("* id:'etCV2'", "#{$Configuration["CardCV"]}")
        sleep 2
        enter_text("* id:'etPostCode'", "#{$Configuration["CardPINCode"]}")
        sleep 2
        tap_mark "SAVE"
        sleep 10
    else
    ios_connect(session)
    sleep 2
    wait_for_element_exists("UITextField")
    clear_text("UITextField")
    touch(query("textField")[0])
    if keyboard_visible?
      keyboard_enter_text "#{$Configuration["CardNo"]}"
    end  
    sleep 2
    var = "#{$Configuration["CardExpiry"]}"
    var = var.gsub(/\//,'').to_s
    if keyboard_visible?
      keyboard_enter_text var
      keyboard_enter_text "#{$Configuration["CardCV"]}"
      keyboard_enter_text "#{$Configuration["CardPINCode"]}"
    end 
    sleep 2
    tap_mark 'SAVE'
    sleep 10
end
end

Then(/^Delete my card-details$/) do 
  session="S1"
    if $Configuration[session+"DeviceType"] == "Android"
        set_default_device($session[session])
        sleep 2
        start_test_server_in_background
        system("#{default_device.adb_command} shell input keyevent KEYCODE_ENTER")
        sleep 2
         touch("* {text CONTAINS 'ACCOUNT'}")
         sleep 3
        tap_mark 'WALLET'
        sleep 5
        if element_exists("* text:'This is your default payment method'")
          perform_action('swipe', 'left')
        else
          perform_action('swipe', 'right')
        end
        sleep 5
        tap_mark 'butPaymentMethDefault'
        sleep 5
        perform_action('swipe', 'right')
        sleep 5
        tap_mark 'butPaymentMethDelete'
        sleep 2
        tap_mark 'Yes'
        wait_for_element_exists("* {text CONTAINS 'Deleted'}")
    else
    ios_connect(session)
    sleep 2
    tap_mark 'btnDefaultCard'
    sleep 2
    tap_mark 'Yes'
    sleep 5
    swipe :left, force: :strong
    sleep 3
    tap_mark 'btnDeleteCard'
    sleep 2
    tap_mark 'Yes'
    sleep 5
end
end
##Then I should able to see the list of RECENT VISITS
Then(/^I should able to see the list of RECENT VISITS$/) do 
  session="S1"
    if $Configuration[session+"DeviceType"] == "Android"
        set_default_device($session[session])
        sleep 2
        wait_for_element_exists("* id:'tvVenueName'")
        var_hotel = query("* id:'tvVenueName'", :text)
        var_time = query("* id:'tvVenueTime'", :text)
        var_pay = query("* id:'tvVenuePrice'", :text)
        scroll_down
        sleep 2
        var_hotel = var_hotel + query("* id:'tvVenueName'", :text)
        var_time = var_time + query("* id:'tvVenueTime'", :text)
        var_pay = var_pay + query("* id:'tvVenuePrice'", :text)
        scroll_down
        sleep 2
        var_hotel = var_hotel + query("* id:'tvVenueName'", :text)
        var_time = var_time + query("* id:'tvVenueTime'", :text)
        var_pay = var_pay + query("* id:'tvVenuePrice'", :text)
        var_hotel = var_hotel.uniq
        var_time = var_time.uniq
        var_pay = var_pay.uniq
        puts "\nRecent Visits with unique Venue Name, Date and Payment"
        puts "\n"
        p_arry(var_hotel)
        p_arry(var_time)
        p_arry(var_pay)
        puts "\n"
        scroll_up
        sleep 2
        scroll_up
        sleep 2
    else
    ios_connect(session)
    sleep 10
    var = query("UILabel", :text)
    scroll("UITableView", :down)
    sleep 3
    var = query("UILabel", :text)
    scroll("UITableView", :down)
    sleep 3
    var = query("UILabel", :text)
    scroll("UITableView", :down)
    sleep 3
    var = query("UILabel", :text)
    scroll("UITableView", :down)
    sleep 3
    var = var.uniq
    var.delete("Tap to view your receipts")
    var.delete("MY ACCOUNT")
    var.delete("RECENT VISITS")
    scroll("UITableView", :up)
    sleep 2
    scroll("UITableView", :up)
    sleep 2
    scroll("UITableView", :up)
    sleep 2
    scroll("UITableView", :up)
    sleep 2
    p_arry(var)
end
end

##Then I enter tip-amount as 5
Then(/^I enter tip-amount as ([\d]+)$/) do |ops|
  session="S1"
    if $Configuration[session+"DeviceType"] == "Android"
        set_default_device($session[session])
        sleep 2
        keyboard_enter_text "#{ops.to_s}"
        sleep 2
        tap_mark 'button1'
    else
    ios_connect(session)
    sleep 2
    wait_for_keyboard
    keyboard_enter_text("#{ops.to_s}")  
    sleep 2
    tap_mark 'DONE'
end
end

##And Complete Payment Process with Concur
Then(/^Complete Payment Process with Concur$/) do 
  session="S1"
    if $Configuration[session+"DeviceType"] == "Android"
        set_default_device($session[session])
        sleep 2
        begin
        wait_for_element_exists("* id:'butPay'")
        tap_mark 'butPay'
        rescue  
        end
        sleep 5
        wait_for_element_exists("* id:'butPayBill'")
        tap_mark 'butPayBill'
        sleep 10
        if (!query("* id:'expense_switch'", :isChecked)[0])
          tap_mark 'expense_switch'
          sleep 4
        end
        tap_mark 'MEMO'
        sleep 2
        query("* id:'memo_edittext_title'", setText: '')
        query("* id:'memo_edittext_title'", setText: 'Emp_random1234')
        sleep 2
        query("* id:'memo_edittext_description'", setText: '')
        query("* id:'memo_edittext_description'", setText: 'Memo Expenses')
        sleep 2
        tap_mark 'SAVE'
        sleep 3
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
      sleep 5
      begin
          tap_mark 'down'
          sleep 5
      rescue 
      end
      tap_mark 'btnPay'
      sleep 3
      begin
          tap_mark 'Continue with no gratuity'
          sleep 3
      rescue 
      end
      sleep 5
      if (query("UISwitch", :isOn)[0] == 0)
        touch(query("UISwitch"))
        sleep 4
      end
      tap_mark 'MEMO'
      sleep 2
      clear_text('UITextField')
      sleep 2
      touch(query("UITextField")[0])
      wait_for_keyboard 
      keyboard_enter_text("Emp_random1234")
      sleep 2
      tap_mark 'SAVE'
      sleep 5
      tap_mark 'Pay'
      sleep 15
      tap_mark '4 stars'
      sleep 2
      tap_mark 'btnDone'
      sleep 5
      tap_mark 'btnCloseMap'
end
end

##And pay using Concur
Then(/^pay using Concur$/) do 
  session="S1"
    if $Configuration[session+"DeviceType"] == "Android"
        set_default_device($session[session])
        sleep 5
        tap_mark 'butSendReceiptExpenseManager'
        sleep 3
        tap_mark 'Yes'
        sleep 3
        query("* id:'memo_edittext_title'", setText: '')
        query("* id:'memo_edittext_title'", setText: 'Emp_random1234')
        sleep 2
        query("* id:'memo_edittext_description'", setText: '')
        query("* id:'memo_edittext_description'", setText: 'Memo Expenses')
        sleep 2
        tap_mark 'SAVE'
        sleep 5
        check_element_exists("* text:'Receipt was already sent'")
        sleep 2
    else
      ios_connect(session)
      sleep 5
      tap_mark 'SEND RECEIPT TO EXPENSES'
      sleep 3
      tap_mark 'Concur'
      sleep 3
      tap_mark 'Yes'
      sleep 3
      clear_text('UITextField')
      sleep 2
      touch(query("UITextField")[0])
      wait_for_keyboard 
      keyboard_enter_text("Emp_random1234")
      sleep 2
      tap_mark 'SAVE'
      sleep 5
      check_element_exists("* text:'RECEIPT HAS BEEN EXPENSED'")
      sleep 2
    end
end