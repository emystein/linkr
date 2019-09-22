require "rails_helper"

describe UsersController, :type => :controller do
  sign_me_in

  describe "Search user bookmarks" do
    it "assigns the filtered bookmark as @bookmark" do
      kitchen_table_bookmark = Bookmark.create!(user_id: subject.current_user.id, title: "Kitchen table")

      other_user = create(:user)
      expect(other_user.id).not_to be(subject.current_user.id)

      not_own_kitchen_table_bookmark = Bookmark.create!(user_id: other_user.id, title: "Kitchen table")

      get :show, :params => { id: subject.current_user.id, search_query: "kitchen" }
      expect(assigns(:bookmarks)).to contain_exactly(kitchen_table_bookmark)
    end
  end
end
