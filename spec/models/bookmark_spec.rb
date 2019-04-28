require "spec_helper"

describe Bookmark, type: :model do
  before do
    @user = create(:user)
    @kitchen_table_bookmark = @user.bookmarks.create!(title: "Kitchen table")
    @dinner_table_bookmark = @user.bookmarks.create!(title: "Dinner table")
  end

  it { should validate_presence_of(:title) }

  context "Tags" do
    it "Assign tags" do
      @kitchen_table_bookmark.tag_list.add("tag1", "tag2")
      @kitchen_table_bookmark.save

      @retrieved = Bookmark.find(@kitchen_table_bookmark.id)

      @retrieved.tag_list.should == ["tag1", "tag2"]
    end
  end

  context "Search" do
    it "Find kitchen table" do
      @bookmarks = Bookmark.search("kitchen table")
      @bookmarks.should == [@kitchen_table_bookmark]
    end
    it "Find kitchen table case insensitive" do
      @bookmarks = Bookmark.search("Kitchen Table")
      @bookmarks.should == [@kitchen_table_bookmark]
    end
    it "Find kitchen table truncated first term" do
      @bookmarks = Bookmark.search("tchen table")
      @bookmarks.should == [@kitchen_table_bookmark]
    end
    it "Find kitchen table truncated last term" do
      @bookmarks = Bookmark.search("Kitchen tab")
      @bookmarks.should == [@kitchen_table_bookmark]
    end
    it "Find dinner table" do
      @bookmarks = Bookmark.search("dinner table")
      @bookmarks.should == [@dinner_table_bookmark]
    end
  end
end
