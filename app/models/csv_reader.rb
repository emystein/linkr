require "smarter_csv"

class CsvReader
  def self.read(csv_file_path, csv_filter)
    rows = SmarterCSV.process(csv_file_path)
    rows.filter &csv_filter.row_filter
  end
end
