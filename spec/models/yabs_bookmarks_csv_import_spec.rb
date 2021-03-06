require 'rails_helper'

describe CSV, type: :model do
  before do
    @user = create(:user)
    @yabs_bookmarks_csv = file_fixture('/yabs_bookmarks.csv')
  end

  it 'Import YABS Bookmars CSV' do
    YabsCsvBookmarks.import(@user, @yabs_bookmarks_csv)

    expect(Bookmark.all.map(&:title)).to match_array(
      ['Simple Planning for Startups • William Pietri',
       'Discovering Docker and Cassandra']
    )

    expect(Bookmark.all.map(&:url)).to match_array(
      ['http://williampietri.com/writing/2014/simple-planning-for-startups/',
       'http://blog.ditullio.fr/2016/06/10/docker-docker-basics-cassandra/']
    )

    expect(Bookmark.all.filter(&:private)).to be_empty

    expect(Bookmark.all.map(&:tag_list)).to match_array([%w[agile], %w[cassandra docker]])
  end

  it 'Skip already imported URLs' do
    imported = YabsCsvBookmarks.import(@user, @yabs_bookmarks_csv)
    expect(imported.count).to eq(2)
    expect(Bookmark.all.count).to eq(2)

    # Re-execute and verify no duplicates are imported
    imported = YabsCsvBookmarks.import(@user, @yabs_bookmarks_csv)
    expect(imported.count).to eq(0)
    expect(Bookmark.all.count).to eq(2)
  end
end
