require "rails_helper"

describe DashboardController, :type => :controller do
  sign_me_in

  def valid_attributes
    { "user_id" => subject.current_user.id, "title" => "El título", "url" => "La URL" }
  end

  def persist_bookmark(action)
    persist_bookmark_with_params(action, Hash.new)
  end

  def persist_bookmark_with_params(action, extra_parameters, is_private = false)
      bookmark = Bookmark.create! valid_attributes
      bookmark.private = is_private 
      bookmark.save

      basic_parameters = { commit: action, bookmark_ids: [bookmark.id] }
      
      request_parameters = basic_parameters.merge(extra_parameters)

      post :execute_actions, :params => request_parameters

      get :show

      assigns(:bookmarks).find{|b| b.id == bookmark.id}
  end

  describe "Bookmark Actions" do
    it "mark bookmark as private" do
      persisted_bookmark = persist_bookmark_with_params('make_private', Hash.new, is_private = false)

      expect(persisted_bookmark.private).to be true
    end

    it "mark bookmark as public" do
      persisted_bookmark = persist_bookmark_with_params('make_public', Hash.new, is_private = true)

      expect(persisted_bookmark.private).to be false
    end

    it "delete bookmark" do
      persisted_bookmark = persist_bookmark('delete')

      expect(persisted_bookmark).to be_nil
    end

    it "add tag to bookmark" do
      persisted_bookmark = persist_bookmark_with_params('add_tag', { tag: 'new' })

      expect(persisted_bookmark.tag_list).to include('new')
    end

    it "don't mark private bookmarks when skip bookmark ids parameter" do
      bookmark = Bookmark.create! valid_attributes

      post :execute_actions, :params => { commit: 'make_private' }

      get :show

      persisted_bookmark = assigns(:bookmarks).find{|b| b.id == bookmark.id}

      expect(persisted_bookmark.private).to be false
    end
  end
end
