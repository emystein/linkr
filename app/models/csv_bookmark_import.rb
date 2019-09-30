require 'smarter_csv'

class CsvBookmarkImport
  def self.import(user, csv_file, csv_metadata, bookmark_factory)
    rows = SmarterCSV.process(csv_file.path)

    rows = rows.filter { |row| csv_metadata.id(row).is_a? Numeric }

    ActiveRecord::Base.transaction do
      rows.each do |row|
        bookmark = bookmark_factory.create_from_csv_row(row, user)
        bookmark.save
      end
    end
  end
end
