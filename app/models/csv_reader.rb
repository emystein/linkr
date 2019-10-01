require "smarter_csv"

class CsvReader
  # TODO add tests
  def self.read(csv_file, csv_metadata)
    rows = SmarterCSV.process(csv_file.path)
    rows.filter &csv_metadata.row_filter
  end
end
