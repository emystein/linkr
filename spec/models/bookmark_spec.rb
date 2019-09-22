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

      expect(@retrieved.tag_list).to eq(["tag1", "tag2"])
    end
  end

  context "Search" do
    it "Find kitchen table" do
      @bookmarks = Bookmark.search("kitchen table")
      expect(@bookmarks).to eq([@kitchen_table_bookmark])
    end
    it "Find kitchen table case insensitive" do
      @bookmarks = Bookmark.search("Kitchen Table")
      expect(@bookmarks).to eq([@kitchen_table_bookmark])
    end
    it "Find kitchen table truncated first term" do
      @bookmarks = Bookmark.search("tchen table")
      expect(@bookmarks).to eq([@kitchen_table_bookmark])
    end
    it "Find kitchen table truncated last term" do
      @bookmarks = Bookmark.search("Kitchen tab")
      expect(@bookmarks).to eq([@kitchen_table_bookmark])
    end
    it "Find dinner table" do
      @bookmarks = Bookmark.search("dinner table")
      expect(@bookmarks).to eq([@dinner_table_bookmark])
    end
  end
end
