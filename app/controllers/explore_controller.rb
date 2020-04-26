# frozen_string_literal: true

class ExploreController < ApplicationController
  def index
    @bookmarks = Bookmark.public_bookmarks.take(10)
    @tag_count_by_date = TagCountByDate.where('created_at >= ?', 1.week.ago).take(30)
  end
end
