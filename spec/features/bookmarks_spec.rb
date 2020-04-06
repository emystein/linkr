require 'rails_helper'

describe "Bookmarks:", :type => :feature do
  before :each do
    @user = create(:user)

    visit new_user_session_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => @user.password
    click_button "Log in"
  end

  it "A user should be able to create a bookmark" do
    visit new_bookmark_path
    expect(page).to have_content("Save a new bookmark")
    fill_in "Title", :with => "Proggit"
    fill_in "Url", :with => "http://reddit.com/r/programming"
    fill_in "Notes", :with => "The programming subreddit"
    click_button "Create Bookmark"
    expect(page).to have_content("Bookmark was successfully created")
  end

  it "A user should be able to create a private bookmark" do
    visit new_bookmark_path

    fill_in "Title", :with => "Proggit"
    fill_in "Url", :with => "http://reddit.com/r/programming"
    page.check('Private')

    click_button "Create Bookmark"

    expect(page).to have_content("[Private] Proggit")
  end

  # it "A user should be able to see their own bookmarks" do
  #   pending
  # end

  # it "A user should be able to see their own bookmarks" do
  #   pending
  # end

  # it "A user should be able to see everyone's bookmarks" do
  #   pending
  # end

  # it "A user should be able to see another user's bookmarks" do
  #   pending
  # end

end
