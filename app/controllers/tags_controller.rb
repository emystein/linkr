class TagsController < ApplicationController
  before_action :require_user

  def index
    @tags = Bookmark.public_bookmarks.tag_counts
    @user_tags = current_user.bookmarks.tag_counts
  end

  def show
    @tag = params[:id]
    @bookmarks = Bookmark.public_bookmarks.tagged_with(@tag, :any => true).paginate(:page => params[:page])
  end
end

