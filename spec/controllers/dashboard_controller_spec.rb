require "rails_helper"

describe DashboardController, :type => :controller do
  sign_me_in

  def valid_attributes
    { "user_id" => subject.current_user.id, "title" => "El título", "url" => "La URL" }
  end

  def persist_bookmark(action, is_private = false)
    persist_bookmark_with_params(action, Hash.new, is_private)
  end

  def persist_bookmark_with_params(action, extra_parameters, is_private = false)
    bookmark = Bookmark.create! valid_attributes.merge({ private: is_private })

    basic_parameters = { commit: action, bookmark_ids: [bookmark.id] }

    request_parameters = basic_parameters.merge(extra_parameters)

    post :execute_actions, :params => request_parameters

    get :show

    assigns(:bookmarks).find { |b| b.id == bookmark.id }
  end

  describe "Bookmark Actions" do
    it "mark bookmark as private" do
      bookmark = persist_bookmark("make_private", is_private = false)

      expect(bookmark.private).to be true
    end

    it "mark bookmark as public" do
      bookmark = persist_bookmark("make_public", is_private = true)

      expect(bookmark.private).to be false
    end

    it "delete bookmark" do
      bookmark = persist_bookmark("delete")

      expect(bookmark).to be_nil
    end

    it "add tag to bookmark" do
      bookmark = persist_bookmark_with_params("add_tag", { tag: "new" })

      expect(bookmark.tag_list).to include("new")
    end

    it "don't mark private bookmarks when skip bookmark ids parameter" do
      bookmark = Bookmark.create! valid_attributes

      post :execute_actions, :params => { commit: "make_private" }

      get :show

      bookmark = assigns(:bookmarks).find { |b| b.id == bookmark.id }

      expect(bookmark.private).to be false
    end
  end
end
