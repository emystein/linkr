class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by_id(params[:id])

    if params[:search_query]
      @bookmarks = @user.bookmarks.public_bookmarks.search(params[:search_query]).paginate(:page => params[:page])
    else
      @bookmarks = @user.bookmarks.public_bookmarks.paginate(:page => params[:page])
    end

    # @user_stats = UserStats.new(bookmark_count: @user.bookmarks.count)
  end

  def tags
    @user = User.find_by_id(params[:id])
    @tags = @user.bookmarks.tag_counts
  end
end
