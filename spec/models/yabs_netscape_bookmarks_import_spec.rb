require 'rails_helper'

describe YabsNetscapeBookmarks do
  before do
    @user = create(:user)
  end

  it 'Import Netscape Bookmars' do
    parser = YabsNetscapeBookmarks.new(@user, file_fixture('/yabs_netscape_bookmarks.html'))
    bookmarks = []
    parser.each do |bookmark|
      bookmarks << Bookmark
    end
    expect(bookmarks.count).to be > 0
  end
end
