class ExploreController < ApplicationController
  def index
    @bookmarks = Bookmark.public_bookmarks.take(10)
    @tags = Bookmark.public_bookmarks.tag_counts
  end
end
