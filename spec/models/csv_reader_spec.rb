require 'rails_helper'

describe CsvReader do
  before do
    @yabs_bookmarks_csv = File.open(file_fixture('/yabs_bookmarks.csv'))
  end

  it 'skip filtered rows' do
    # yabs_bookmarks.csv contains header, 2 valid rows, and 1 final invalid row which should be filtered out 

    rows = CsvReader.read(@yabs_bookmarks_csv, YabsCsvFilter)

    expect(rows.count).to eq(2)

    filtered_rows = rows.filter &YabsCsvFilter.row_filter
    expect(filtered_rows).to eq(rows)
  end
end