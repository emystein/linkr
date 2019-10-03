class BookmarksImport
  def self.import(bookmarks)
    imported_bookmarks = []

    ActiveRecord::Base.transaction do
      bookmarks.each do |bookmark|
        imported_bookmarks << bookmark if bookmark.save
      end
    end

    imported_bookmarks
  end
end