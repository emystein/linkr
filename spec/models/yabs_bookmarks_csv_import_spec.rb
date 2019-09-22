require 'rails_helper'
require 'spec_helper'

describe CSV, type: :model do
  before do
    @user = create(:user)
  end

  it 'Import YABS Bookmars CSV' do
    result = Bookmark.yabs_csv_import(@user, File.open('spec/models/yabs_bookmarks.csv'))

    # expect(result.failed_instances.length).to eq(0)

    titles = Bookmark.all.map { | bookmark | bookmark.title }
    expect(titles).to match_array(['Simple Planning for Startups • William Pietri',
                          'Discovering Docker and Cassandra'])

    urls = Bookmark.all.map { | bookmark | bookmark.url }
    expect(urls).to match_array(['http://williampietri.com/writing/2014/simple-planning-for-startups/',
                        'http://blog.ditullio.fr/2016/06/10/docker-docker-basics-cassandra/'])

    private_bookmarks = Bookmark.all.map { | bookmark | bookmark.private } 
    expect(private_bookmarks).to eq([false, false])

    tags = Bookmark.all.map { | bookmark | bookmark.tag_list }
    expect(tags).to match_array([['agile'], ['cassandra', 'docker']])
  end
end
