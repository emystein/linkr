class YabsCsvMetadata
  def self.id(row)
    row[:id]
  end
  def self.row_filter()
    lambda { |row| id(row).is_a? Numeric }
  end
end
