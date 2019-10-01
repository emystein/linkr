class BookmarksCsv
  def self.import(csv_file, csv_filter, bookmark_factory)
    rows = CsvReader.read(csv_file, csv_filter)

    bookmarks = []

    ActiveRecord::Base.transaction do
      rows.each do |row|
        bookmark = bookmark_factory.create_from(row)
        bookmarks << bookmark if bookmark.save
      end
    end

    bookmarks
  end
end
