class YabsCsvMetadata
  def self.row_filter()
    lambda { |row| row[:id].is_a? Numeric }
  end
end
