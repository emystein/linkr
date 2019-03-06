require 'spec_helper'

describe Bookmark, type: :model do
  before do
    @user = create(:user)
    @kitchen_table_bookmark = @user.bookmarks.create!(url: "URL of kitchen table", title: "Kitchen table")
    @dinner_table_bookmark = @user.bookmarks.create!(url: "URL of dinner table", title: "Dinner table")
    @bookmark = create(:bookmark)
  end

  it { should validate_presence_of(:title) }

  context "Search" do
    it "Find kitchen table" do
      @bookmarks = Bookmark.search("kitchen table")
      @bookmarks.length.should == 1
      @bookmarks.first.should == @kitchen_table_bookmark 
    end 
    it "Find kitchen table case insensitive" do
      @bookmarks = Bookmark.search("Kitchen Table")
      @bookmarks.length.should == 1
      @bookmarks.first.should == @kitchen_table_bookmark 
    end 
    it "Find kitchen table truncated first term" do
      @bookmarks = Bookmark.search("tchen table")
      @bookmarks.length.should == 1
      @bookmarks.first.should == @kitchen_table_bookmark 
    end 
    it "Find kitchen table truncated last term" do
      @bookmarks = Bookmark.search("Kitchen tab")
      @bookmarks.length.should == 1
      @bookmarks.first.should == @kitchen_table_bookmark 
    end 
    it "Find dinner table" do
      @bookmarks = Bookmark.search("dinner table")
      @bookmarks.length.should == 1
      @bookmarks.first.should == @dinner_table_bookmark 
    end 
  end
end
