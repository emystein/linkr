class YabsBookmark
  def create_from_csv_row(row, user)
    bookmark = Bookmark.new(user: user, title: row[:title], url: row[:link], private: row[:state] != 'public')
    bookmark.tag_list.add(row[:tags], parse: true)
    bookmark
  end
end
