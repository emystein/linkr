require 'spec_helper'

feature "Navigation Auth'd:" do
  background do
    @user = create(:user)
    visit new_user_session_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => "password"
    click_button "Log in"
    visit dashboard_path
  end

  scenario "dashboard / personal bookmarks" do
    within('nav#site') { click_link('Bookmarks') }
    expect(find('#main')).to have_content('Your Bookmarks')
  end

  scenario "everyone's bookmarks" do
    within('nav#site') { click_link('Everyone') }
    expect(find('#main')).to have_content("Everyone's Bookmarks")
  end

  scenario "public profile" do
    within('nav#profile') { click_link(@user.nickname) }
    expect(find('#main')).to have_content(@user.nickname + "'s Bookmarks")
  end

  scenario "help" do
    within('nav#profile') { click_link('help') }
    expect(find('#main')).to have_content("Help")
  end

  scenario "header link" do
    within('header') { click_link('Linkr') }
    expect(find('#main')).to have_content("Everyone's Bookmarks")
  end
end

feature "Navigation UnAuth'd:" do
  background do
    @user = create(:user)
    visit new_user_session_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => "password"
    click_button "Log in"
    click_link "Logout" 
  end

  scenario "only has login/logout" do
    within('header') {
      expect(find('nav#profile')).to have_content('login')
      expect(find('nav#profile')).to have_content('signup')
    }
  end

  scenario "does not have standard navigation" do
    within('header') {
      expect(find('nav#site')).to_not have_content('Bookmarks')
      expect(find('nav#site')).to_not have_content('Everyone')
    }
  end
end
