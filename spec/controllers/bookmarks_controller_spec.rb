require "rails_helper"

describe BookmarksController, :type => :controller do
  sign_me_in

  # This should return the minimal set of attributes required to create a valid
  # Bookmark. As you add validations to Bookmark, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "user_id" => subject.current_user.id, "title" => "El título", "url" => "La URL" }
  end

  describe "GET index" do
    it "assigns all bookmarks as @bookmarks" do
      bookmark = Bookmark.create! valid_attributes
      get :index
      expect(assigns(:bookmarks)).to eq([bookmark])
    end
  end

  describe "GET show" do
    it "assigns the requested bookmark as @bookmark" do
      bookmark = Bookmark.create! valid_attributes
      post :show, :params => { id: bookmark.id.to_s }
      expect(assigns(:bookmark)).to eq(bookmark)
    end
  end

  describe "Search" do
    it "assigns the filtered bookmark as @bookmarks" do
      kitchen_table_bookmark = Bookmark.create!(user_id: subject.current_user.id, title: "Kitchen table", url: "Kitchen table URL")
      dinner_table_bookmark = Bookmark.create!(user_id: subject.current_user.id, title: "Dinner table", url: "Dinner table URL")
      get :index, :params => { search_query: "kitchen" }
      expect(assigns(:bookmarks)).to contain_exactly(kitchen_table_bookmark)
    end
  end

  describe "GET new" do
    it "assigns a new bookmark as @bookmark" do
      get :new
      expect(assigns(:bookmark)).to be_a_new(Bookmark)
    end
  end

  describe "GET edit" do
    it "assigns the requested bookmark as @bookmark" do
      bookmark = Bookmark.create! valid_attributes
      get :edit, :params => { id: bookmark.id.to_s }
      expect(assigns(:bookmark)).to eq(bookmark)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Bookmark" do
        expect {
          post :create, :params => { bookmark: valid_attributes }
        }.to change(Bookmark, :count).by(1)
        expect(assigns(:bookmark)).to be_a(Bookmark)
        expect(assigns(:bookmark)).to be_persisted
        expect(response).to redirect_to(dashboard_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved bookmark as @bookmark" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Bookmark).to receive(:save).and_return(false)
        post :create, :params => { bookmark: {} }
        expect(assigns(:bookmark)).to be_a_new(Bookmark)
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested bookmark" do
        bookmark = Bookmark.create! valid_attributes
        put :update, :params => { id: bookmark.id, bookmark: valid_attributes }
        expect(assigns(:bookmark)).to eq(bookmark)
        expect(response).to redirect_to(dashboard_url)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested bookmark" do
      bookmark = Bookmark.create! valid_attributes
      expect {
        delete :destroy, :params => { id: bookmark.id.to_s }
      }.to change(Bookmark, :count).by(-1)
      expect(response).to redirect_to(bookmarks_url)
    end
  end

  describe "Import bookmarks" do
    it "import bookmarks from a YABS CSV file" do
      test_bookmarks_import_success(import_format = 'yabs_csv', '/files/yabs_bookmarks.csv', 'text/csv')
    end

    it "import bookmarks from a YABS Netscape bookmarks file" do
      test_bookmarks_import_success(import_format = 'yabs_netscape', '/files/yabs_netscape_bookmarks.html', 'text/html')
    end

    it "rejects unknown file format" do
      bookmarks_file = fixture_file_upload('/files/yabs_bookmarks.csv', 'text/csv')
      
      post :import, params: {import_format: 'unknown', file: bookmarks_file}

      expect(response).to redirect_to("/dashboard")
      expect(assigns(:bookmarks)).to be_empty
      expect(flash[:success]).to_not be_present
      expect(flash[:error]).to be_present
    end
  end

  def test_bookmarks_import_success(import_format, bookmarks_file_path, bookmarks_file_mime_type)
      bookmarks_file = fixture_file_upload(bookmarks_file_path, bookmarks_file_mime_type)

      post :import, params: {import_format: import_format, file: bookmarks_file}

      expect(response).to redirect_to("/dashboard")
      expect(assigns(:bookmarks)).not_to be_empty
      expect(flash[:success]).to be_present
      expect(flash[:error]).to_not be_present
  end

  describe "Export bookmarks" do
    it "export bookmarks" do
      expected_document = NetscapeBookmarks.create_document(subject.current_user.bookmarks)

      get :export

      expect(response.body).to eq(expected_document)
    end
  end
end
