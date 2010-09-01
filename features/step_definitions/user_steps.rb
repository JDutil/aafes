When /Client "(.+)" authenticates/ do |email|
  @user = Factory(:user, :email=>email)
  @user.roles.create(:title=>"client")
  # @user.clients = [Factory(:client)]
  # @user.save
  visit new_user_session_path
  Then "I login with valid credentials"
  Then "I should see \"Login successful!\""
end

Given /^Admin "(.+)" authenticates$/ do |email|
  @user = Factory(:user, :email=>email)
  @user.roles.create(:title=>"admin")
  # @user.clients = [Factory(:client)]
  # @user.save
  visit new_user_session_path
  Then "I login with valid credentials"
  Then "I should see \"Login successful!\""
end

Given /^I am the registered user (.+)$/ do |email|
  @user = Factory(:user, :email=>email)
end

When /^I login with valid credentials$/ do
  fill_in('Email', :with => @user.email)
  fill_in('Password', :with => @user.password)
  click_button("Login")
end

When /^I login with invalid credentials$/ do
  fill_in('Email', :with => @user.email)
  fill_in('Password', :with => "invalid")
  click_button("Login")
end