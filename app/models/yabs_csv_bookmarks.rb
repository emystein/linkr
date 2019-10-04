class YabsCsvBookmarks
  def self.import(user, csv_file_path)
    bookmarks = CsvBookmarks.from(csv_file_path, YabsCsvFilter, YabsBookmarkFactory.new(user))
    BookmarksImport.import(bookmarks)
  end
end
