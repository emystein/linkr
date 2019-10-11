class BookmarksExportController < ApplicationController
  before_action :authenticate_user!

  def create
    document = NetscapeBookmarks.create_document(current_user.bookmarks)
    send_data(document, :filename => 'bookmarks.html')
  end
end
