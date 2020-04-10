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

  it "mark bookmark as private" do
    create(:bookmark)

    visit dashboard_path

    find('input#bookmark_ids_').click
    find_button(value: 'make_private').click

    expect(page).to have_content(@user.nickname + "'s Bookmarks")
    # TODO improve assertions
  end
end
