class BookmarksCsv
  def self.import(csv_file, csv_filter, bookmark_factory)
    bookmarks = CsvBookmarks.from(csv_file, csv_filter, bookmark_factory)
    BookmarksImport.import(bookmarks)
  end
end
