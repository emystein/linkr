require 'spec_helper'

feature "Dashboard:" do
  background do
    @user = create(:user)
    visit new_user_session_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => "password"
    click_button "Log in"
  end

  scenario "Users should be have a dashboard" do
    visit dashboard_path
    page.should have_content("Your Bookmarks")
  end
end
