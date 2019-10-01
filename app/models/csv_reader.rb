require "smarter_csv"

class CsvReader
  def self.read(csv_file, csv_filter)
    rows = SmarterCSV.process(csv_file.path)
    rows.filter &csv_filter.row_filter
  end
end
