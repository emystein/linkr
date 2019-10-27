require 'rails_helper'

describe "Navigation Auth'd:", :type => :feature do
  before :each do
    @user = create(:user)
    visit new_user_session_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => "password"
    click_button "Log in"
    visit dashboard_path
  end

  it "dashboard / personal bookmarks" do
    within('nav.navbar') { click_link('Dashboard') }
    expect(find('#main')).to have_content("#{@user.nickname}'s Bookmarks")
  end

  it "everyone's bookmarks" do
    within('nav.navbar') { click_link('Bookmarks') }
    expect(find('#main')).to have_content("Everyone's Bookmarks")
  end

  it "public profile" do
    within('nav.navbar') { click_link(@user.nickname) }
    expect(find('#main')).to have_content("#{@user.nickname}'s Bookmarks")
  end

  it "header link" do
    within('nav.navbar') { click_link('Linkr') }
    expect(find('#main')).to have_content("Bookmarks")
  end
end

describe "Navigation UnAuth'd:" do
  before :each do
    @user = create(:user)
    visit new_user_session_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => "password"
    click_button "Log in"
    click_link "Logout" 
  end

  it "has navigation" do
    expect(find('nav.navbar')).to have_content('Dashboard')
    expect(find('nav.navbar')).to have_content('Bookmark')
    expect(find('nav.navbar')).to have_content('Log in')
    expect(find('nav.navbar')).to have_content('Sign up')
  end
end
