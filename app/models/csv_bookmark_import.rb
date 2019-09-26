require 'smarter_csv'

class CsvBookmarkImport
  def self.import(user, csv_file, import_strategy)
    bookmarks = []

    rows = SmarterCSV.process(csv_file.path)

    rows = rows.filter { |row| row[:id].is_a? Numeric }

    ActiveRecord::Base.transaction do
      rows.each do |row|
        next if Location.where(url: row[:link]).exists?

        bookmarks << save_bookmark_from_csv_row(row, user, import_strategy)
      end
    end

    bookmarks
  end

  def self.save_bookmark_from_csv_row(row, user, import_strategy)
    bookmark = import_strategy.create_bookmark_from_yabs_csv_row(row, user)
    bookmark.save
    bookmark
  end
end
