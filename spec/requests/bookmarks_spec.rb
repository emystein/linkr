require 'spec_helper'

feature "Bookmarks:" do
  background do
    @user = create(:user)
    visit new_user_session_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
    click_button "Log in"
  end

  scenario "A user should be able to create a bookmark" do
    visit new_bookmark_path
    page.should have_content("Save a new bookmark")
    fill_in "Title", :with => "Proggit"
    fill_in "Url", :with => "http://reddit.com/r/programming"
    fill_in "Notes", :with => "The programming subreddit"
    click_button "Create Bookmark"
    page.should have_content("Bookmark was successfully created")
  end

  # scenario "A user should be able to see their own bookmarks" do
  #   pending
  # end

  # scenario "A user should be able to see their own bookmarks" do
  #   pending
  # end

  # scenario "A user should be able to see everyone's bookmarks" do
  #   pending
  # end

  # scenario "A user should be able to see another user's bookmarks" do
  #   pending
  # end

end
