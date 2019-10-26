class ExploreController < ApplicationController
  def index
    @bookmarks = Bookmark.public_bookmarks.take(10)
    @tag_count_by_date = TagCountByDate.all
  end
end
