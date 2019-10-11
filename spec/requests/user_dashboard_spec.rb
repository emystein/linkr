require 'spec_helper'

feature "User Dashboard:" do
  background do
    @user = create(:user)
    visit new_user_session_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => "password"
    click_button "Log in"
  end

  scenario "Users should have a dashboard" do
    visit dashboard_path
    expect(page).to have_content(@user.nickname + "'s Bookmarks")
  end
end
