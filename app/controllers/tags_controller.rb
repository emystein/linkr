class TagsController < ApplicationController
  # before_action :require_user

  def index
    @tags = Bookmark.public_bookmarks.tag_counts
    if current_user
      @user_tags = current_user.bookmarks.tag_counts
    else
      @user_tags = []
    end
  end

  def show
    @tag = params[:id]
    @bookmarks = Bookmark.public_bookmarks.tagged_with(@tag, :any => true).paginate(:page => params[:page])
  end
end

