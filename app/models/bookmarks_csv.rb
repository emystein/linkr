class BookmarksCsv
  def self.import(csv_file, csv_filter, bookmark_factory)
    bookmarks = CsvBookmarks.from(csv_file, csv_filter, bookmark_factory)

    imported_bookmarks = []

    ActiveRecord::Base.transaction do
      bookmarks.each do |bookmark|
        imported_bookmarks << bookmark if bookmark.save
      end
    end

    imported_bookmarks
  end
end
