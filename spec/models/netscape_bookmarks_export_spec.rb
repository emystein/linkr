require "rails_helper"

describe NetscapeBookmarks, type: :model do
  before do
    @user = create(:user)
  end

  it "Map Netscape Bookmarks" do
    bookmarks = YabsCsvBookmarks.import(@user, file_fixture("/yabs_bookmarks.csv"))

    netscape_bookmarks = NetscapeBookmarks.map(bookmarks)

    expect(netscape_bookmarks.count).to eq(bookmarks.count)
  end

  it "Export Netscape Bookmarks" do
    bookmarks = YabsCsvBookmarks.import(@user, file_fixture("/yabs_bookmarks.csv"))

    document = NetscapeBookmarks.create_document(bookmarks)

    expect(document).to_not be_nil
  end
end