require 'rails_helper'

describe "User Dashboard:", :type => :feature do
  before :each do
    @user = create(:user)
    visit new_user_session_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => "password"
    click_button "Log in"
  end

  it "Users should have a dashboard" do
    visit dashboard_path
    expect(page).to have_content(@user.nickname + "'s Bookmarks")
  end
end
