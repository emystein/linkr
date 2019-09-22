require 'spec_helper'

feature "Signing Up:" do
  scenario "The homepage should have a signup link" do
    visit root_path
    expect(page).to have_content("signup")
  end

  scenario "Allows the creation of new accounts" do
    visit new_user_registration_path
    fill_in 'Nickname', :with => "jack"
    fill_in 'Email', :with => "jack@example.com"
    fill_in 'Password', :with => "password"
    fill_in 'Password confirmation', :with => "password"
    click_button "Sign up"
    expect(page).to have_content("successfully")
  end

  scenario "Does not allow account creation without required information" do
    visit new_user_registration_path
    click_button "Sign up"
    expect(page).to have_content("errors prohibited this user from being saved")
  end
end

feature "Logging In:" do
  background do
    @user = create(:user)
  end

  scenario "The homepage should have a login link" do
    visit root_path
    expect(page).to have_content("login")
  end

  scenario "Allows a user to login using their email and password" do
    visit new_user_session_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => "password"
    click_button "Log in"
    expect(page).to have_content("successfully")
  end

  scenario "Does not authenticate a user with invalid credentials" do
    visit new_user_session_path
    fill_in "Email", :with => @user.nickname
    fill_in "Password", :with => "wrong-password"
    click_button "Log in"
    expect(page).to have_content("Invalid Email or password")
  end

  scenario "Has a signup link for people who do not have accounts" do
    visit new_user_session_path
    expect(page).to have_content("Sign up")
  end
end

feature "Logging Out:" do
  background do
    @user = create(:user)
    visit new_user_session_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
    click_button "Log in"
  end

  scenario "Authenticated users should see a logout link" do
    expect(page).to have_content("Logout")
  end

  scenario "Authenticated users should be able to log out" do
    click_link("Logout")
    expect(page).to have_content("Log in")
  end
end
