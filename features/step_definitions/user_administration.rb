Given /^that no user "([^\"]*)" exists$/ do |login|
  User.count( :conditions => { :login => login } ).should == 0
end

When /^I create a new user "([^\"]*)" with password "([^\"]*)" and email "([^\"]*)"$/ do |login, password, email|
  visit new_user_path
  fill_in "user_name", :with => login
  fill_in "user_login", :with => login
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  fill_in "user_password_confirmation", :with => password
  click_button "Sign Up"
end

Then /^I should see it's "([^\"]*)" login and "([^\"]*)" email$/ do |login, email|
  response.should contain( login )
  response.should contain( email )
end

Given /^that a user "([^\"]*)" with password "([^\"]*)" and email "([^\"]*)" exists$/ do |login, password, email|
  User.create!( :login => login, :password => password, :email => email, :password_confirmation => password )
end

When /^I visit the "([^\"]*)" user's profile page$/ do |login|
  visit user_path( User.find_by_login( login ) )
end

Then /^the user "([^\"]*)" can log in with password "([^\"]*)"$/ do |login, password|
  fill_in "login", :with => login
  fill_in "password", :with => password
  click_button "Log In"
  response.should contain("Logged in successfully")
end

Given /^that a user "([^\"]*)" with password "([^\"]*)" is logged in$/ do |login, password|
  visit new_session_path
  fill_in "login", :with => login
  fill_in "password", :with => password
  click_button "Log In"
end
