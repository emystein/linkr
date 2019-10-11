class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])

    if params[:search_query]
      @bookmarks = @user.bookmarks.public_bookmarks.search(params[:search_query]).paginate(:page => params[:page])
    else
      @bookmarks = @user.bookmarks.public_bookmarks.paginate(:page => params[:page])
    end

    @tags = @user.bookmarks.tag_counts
  end

  def tags
    @user = User.find_by_id(params[:id])
    @tags = @user.bookmarks.tag_counts
  end
end
