require 'rails_helper'

describe "Signing Up:", :type => :feature do
  it "The homepage should have a signup link" do
    visit root_path
    expect(page).to have_content("Sign up")
  end

  it "Allows the creation of new accounts" do
    visit new_user_registration_path
    fill_in 'Nickname', :with => "jack"
    fill_in 'Email', :with => "jack@example.com"
    fill_in 'Password', :with => "password"
    fill_in 'Password confirmation', :with => "password"
    click_button "Sign up"
    expect(page).to have_content("successfully")
  end

  it "Does not allow account creation without required information" do
    visit new_user_registration_path
    click_button "Sign up"
    expect(page).to have_content("errors prohibited this user from being saved")
  end
end

describe "Logging In:", :type => :feature do
  before :each do
    @user = create(:user)
  end

  it "The homepage should have a login link" do
    visit root_path
    expect(page).to have_content("Log in")
  end

  it "Allows a user to login using their email and password" do
    visit new_user_session_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => "password"
    click_button "Log in"
    expect(page).to have_content("successfully")
  end

  it "Does not authenticate a user with invalid credentials" do
    visit new_user_session_path
    fill_in "Email", :with => @user.nickname
    fill_in "Password", :with => "wrong-password"
    click_button "Log in"
    expect(page).to have_content("Invalid Email or password")
  end

  it "Has a signup link for people who do not have accounts" do
    visit new_user_session_path
    expect(page).to have_content("Sign up")
  end
end

describe "Logging Out:", :type => :feature do
  before :each do
    @user = create(:user)
    visit new_user_session_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
    click_button "Log in"
  end

  it "Authenticated users should see a logout link" do
    expect(page).to have_content("Logout")
  end

  it "Authenticated users should be able to log out" do
    click_link("Logout")
    expect(page).to have_content("Log in")
  end
end
