require "spec_helper"

describe User, type: :model do
  before do
    @user = create(:user)
  end

  it { should validate_presence_of(:nickname) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
  it { should validate_uniqueness_of(:nickname) }

  context "Login finder:" do
    it "can find by nickname (login)" do
      User.by_login(@user.nickname).first.should == @user
    end

    it "can find by email (login)" do
      User.by_login(@user.email).first.should == @user
    end
  end

  context "Bookmarks" do
    it "persist and retrieve bookmarks" do
      @kitchen_table_bookmark = @user.bookmarks.create!(title: "Kitchen table")
      @dinner_table_bookmark = @user.bookmarks.create!(title: "Dinner table")

      @user.save

      @retrieved = User.find(@user.id)
      @retrieved.bookmarks.should == @user.bookmarks
    end
  end

  context "Tags" do
    it "tag counts" do
      @kitchen_table_bookmark = @user.bookmarks.create!(title: "Kitchen table")
      @kitchen_table_bookmark.tag_list.add("tag1", "tag2")
      @kitchen_table_bookmark.save
      @dinner_table_bookmark = @user.bookmarks.create!(title: "Dinner table")
      @dinner_table_bookmark.tag_list.add("tag1")
      @dinner_table_bookmark.save

      @user.save

      tags = @user.bookmarks.tag_counts.map { |tag| { tag.name => tag.count } }

      tags.should == [{ "tag1" => 2 }, { "tag2" => 1 }]
    end
  end
end
