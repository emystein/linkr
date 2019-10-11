class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      authenticate_user!
      @user = current_user
    end

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

  def current_user_bookmarks_by_tag
    @bookmarks = current_user.bookmarks.public_bookmarks.tagged_with(params[:tag], :any => true).paginate(:page => params[:page])
  end
end
