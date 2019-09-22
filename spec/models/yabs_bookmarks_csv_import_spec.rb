require 'csv'
require 'rails_helper'
require 'spec_helper'

describe CSV, type: :model do
  before do
    @user = create(:user)
  end

  it 'Import URL' do
    result = Bookmark.yabs_csv_import(File.open('spec/models/yabs_bookmarks.csv'), @user)
    expect(result.failed_instances.length).to eq(0)
    expect(result.num_inserts).to eq(1)
    expect(Bookmark.all.count).to eq(2)
  end
end
