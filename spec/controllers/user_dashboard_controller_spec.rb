require "rails_helper"

describe UserDashboardController, :type => :controller do
  sign_me_in

  def valid_attributes
    { "user_id" => subject.current_user.id, "title" => "El título", "url" => "La URL" }
  end

  describe "Bookmark Actions" do
    it "mark bookmark as private" do
      bookmark = Bookmark.create! valid_attributes

      get :actions, :params => { commit: 'make_private', bookmark_ids: [bookmark.id] }

      get :show

      persisted_bookmark = assigns(:bookmarks).find{|b| b.id == bookmark.id}
      expect(persisted_bookmark.private).to be true
    end

    it "mark bookmark as public" do
      bookmark = Bookmark.create! valid_attributes
      bookmark.private = true
      bookmark.save

      get :actions, :params => { commit: 'make_public', bookmark_ids: [bookmark.id] }

      get :show

      persisted_bookmark = assigns(:bookmarks).find{|b| b.id == bookmark.id}
      expect(persisted_bookmark.private).to be false
    end

    it "delete bookmark" do
      bookmark = Bookmark.create! valid_attributes

      get :actions, :params => { commit: 'delete', bookmark_ids: [bookmark.id] }

      get :show

      persisted_bookmark = assigns(:bookmarks).find{|b| b.id == bookmark.id}
      expect(persisted_bookmark).to be_nil
    end

    it "add tag to bookmark" do
      bookmark = Bookmark.create! valid_attributes

      get :actions, :params => { commit: 'add_tag', bookmark_ids: [bookmark.id], tag: 'new' }

      get :show

      persisted_bookmark = assigns(:bookmarks).find{|b| b.id == bookmark.id}
      expect(persisted_bookmark.tag_list).to include('new')
    end

    it "don't mark private bookmarks when skip bookmark ids parameter" do
      bookmark = Bookmark.create! valid_attributes

      get :actions, :params => { commit: 'make_private' }

      get :show

      persisted_bookmark = assigns(:bookmarks).find{|b| b.id == bookmark.id}
      expect(persisted_bookmark.private).to be false
    end
  end
end
