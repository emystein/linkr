require "rails_helper"

describe BookmarksImportController, :type => :controller do
  sign_me_in

  describe "Import bookmarks" do
    it "import bookmarks from a YABS CSV file" do
      test_bookmarks_import_success(import_format = 'yabs_csv', '/files/yabs_bookmarks.csv', 'text/csv')
    end

    it "import bookmarks from a YABS Netscape bookmarks file" do
      test_bookmarks_import_success(import_format = 'yabs_netscape', '/files/yabs_netscape_bookmarks.html', 'text/html')
    end

    it "rejects unknown file format" do
      bookmarks_file = fixture_file_upload('/files/yabs_bookmarks.csv', 'text/csv')
      
      post :create, params: {import_format: 'unknown', file: bookmarks_file}

      expect(response).to redirect_to("/users/#{subject.current_user.id}")
      expect(assigns(:bookmarks)).to be_empty
      expect(flash[:success]).to_not be_present
      expect(flash[:error]).to be_present
    end
  end

  def test_bookmarks_import_success(import_format, bookmarks_file_path, bookmarks_file_mime_type)
      bookmarks_file = fixture_file_upload(bookmarks_file_path, bookmarks_file_mime_type)

      post :create, params: {import_format: import_format, file: bookmarks_file}

      expect(response).to redirect_to("/users/#{subject.current_user.id}")
      expect(assigns(:bookmarks)).not_to be_empty
      expect(flash[:success]).to be_present
      expect(flash[:error]).to_not be_present
  end
end
