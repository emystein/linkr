require "rails_helper"

describe YabsNetscapeBookmarks, type: :model do
  before do
    @user = create(:user)
  end

  it "Create Netscape Bookmars" do
    parser = YabsNetscapeBookmarks.new(@user, file_fixture("/yabs_netscape_bookmarks.html"))
    bookmarks = []
    parser.each do |bookmark|
      bookmarks << Bookmark
    end
    expect(bookmarks.count).to be > 0
  end

  it "Import YABS Bookmars CSV" do
    YabsNetscapeBookmarks.import(@user, file_fixture("/yabs_netscape_bookmarks.html"))

    expect(Bookmark.all.map(&:title)).to match_array(
      ["Simple Planning for Startups • William Pietri",
       "Discovering Docker and Cassandra"]
    )

    expect(Bookmark.all.map(&:url)).to match_array(
      ["http://williampietri.com/writing/2014/simple-planning-for-startups/",
       "http://blog.ditullio.fr/2016/06/10/docker-docker-basics-cassandra/"]
    )

    expect(Bookmark.all.filter(&:private)).to be_empty

    expect(Bookmark.all.map(&:tag_list)).to match_array([%w[agile], %w[cassandra docker]])
  end
end
