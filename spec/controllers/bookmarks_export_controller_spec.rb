require "rails_helper"

describe BookmarksExportController, :type => :controller do
  sign_me_in

  describe "Export bookmarks" do
    it "export bookmarks" do
      expected_document = NetscapeBookmarks.create_document(subject.current_user.bookmarks)

      post :create

      expect(response.body).to eq(expected_document)
    end
  end
end
