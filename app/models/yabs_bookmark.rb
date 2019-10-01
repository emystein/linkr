# TODO rename to YabsBookmarkFactory
class YabsBookmark
  def initialize(user)
    @user = user
  end

  def create_from(row)
    bookmark = Bookmark.new(user: @user, title: row[:title], url: row[:link], private: row[:state] != "public")
    bookmark.tag_list.add(row[:tags], parse: true)
    bookmark
  end
end
