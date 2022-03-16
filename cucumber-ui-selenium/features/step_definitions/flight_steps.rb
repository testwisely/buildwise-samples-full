# Enter your step denfitions below

# Once you created the step skeleton (right click from feature file),
# add test steps like below:
#  driver.find_element(:text, "Start here").click
# Then perform refactorings to extract the steps into Page Objects.



Given('I am signed in as {string}') do |user|  
  begin
    driver.find_element(:link, "Login")
    sign_in("agileway", "testwise")
  rescue 
    # already logged in
    driver.get(site_url)
  end
  @flight_page = FlightPage.new(driver)
end

When('select oneway trip') do
  @flight_page.select_trip_type("oneway")
end


When('select return trip') do
  @flight_page.select_trip_type("return")
end


When('select depart from {string} to {string} on {string} of {string}') do |from, to, day, month_year|
  @flight_page.select_depart_from(from)
  @flight_page.select_arrive_at(to)
  @flight_page.select_depart_day(day)
  @flight_page.select_depart_month(month_year)
end


When('click {string}') do |string|
  sleep 0.5
  @flight_page.click_continue
end

Then('I should see {string}, {string} and {string} on next page') do |text1, text2, text3|
  the_page_source = driver.page_source
  expect(the_page_source).to include(text1)
  expect(the_page_source).to include(text2)
  expect(the_page_source).to include(text3)
end

When('return on {string} of {string}') do |day, month|
  @flight_page.select_return_date(day, month)
end

