require 'rails_helper'

describe "User Inbox:", :type => :feature do
  before :each do
    @user = create(:user)
    visit new_user_session_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => "password"
    click_button "Log in"
  end

  it "Users should see notifications in their inbox" do
    create(:bookmark)

    @user.notify(type: 'notification', metadata: {title: 'Title', content: 'Content'})

    visit inbox_path

    expect(page).to have_content('Notifications')
    expect(page).to have_content('Title')
    expect(page).to have_content('Content')
  end
end
