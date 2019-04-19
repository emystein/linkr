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
    it "should persist bookmarks" do
      @kitchen_table_bookmark = @user.bookmarks.create!(title: "Kitchen table")
      @dinner_table_bookmark = @user.bookmarks.create!(title: "Dinner table")

      @user.save

      @retrieved = User.find(@user.id)
      @retrieved.bookmarks.should == @user.bookmarks
    end
  end
end
