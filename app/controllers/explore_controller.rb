class ExploreController < ApplicationController
  def index
    @tags = Bookmark.public_bookmarks.tag_counts
  end
end
