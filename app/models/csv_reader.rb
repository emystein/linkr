require "smarter_csv"

class CsvReader
  def self.read(csv_file, row_filter)
    rows = SmarterCSV.process(csv_file.path)
    rows = rows.filter &row_filter
    rows
  end
end
