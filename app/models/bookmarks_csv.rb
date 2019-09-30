require 'smarter_csv'

class BookmarksCsv
  def self.row_filter(csv_metadata)
    lambda { |row| csv_metadata.id(row).is_a? Numeric }
  end

  def self.import(csv_file, csv_metadata, bookmark_factory)
    bookmarks = []

    rows = CsvReader.read(csv_file, row_filter(csv_metadata))

    ActiveRecord::Base.transaction do
      rows.each do |row|
        bookmark = bookmark_factory.create_from_csv_row(row)
        bookmarks << bookmark if bookmark.save
      end
    end

    bookmarks
  end
end
