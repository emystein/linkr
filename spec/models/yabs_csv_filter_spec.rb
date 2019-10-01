require 'rails_helper'

describe YabsCsvFilter do
  it "filter non-numeric IDs" do
    rows = [
        {:id => 1},
        {:id => 'not a number'}
    ]

    filtered = rows.filter &YabsCsvFilter.row_filter

    expect(filtered.count).to be(1)
    expect(filtered[0][:id]).to be(1)
  end
end
