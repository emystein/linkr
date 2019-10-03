class CsvBookmarks
  def self.from(csv_file, csv_filter, bookmark_factory)
    rows = CsvReader.read(csv_file, csv_filter)

    bookmarks = []

    rows.each do |row|
      bookmarks << bookmark_factory.create_from(row)
    end

    bookmarks
  end
end