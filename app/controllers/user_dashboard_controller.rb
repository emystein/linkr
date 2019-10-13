class UserDashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @bookmarks = current_user.bookmarks.paginate(:page => params[:page])
    @tags = current_user.bookmarks.tag_counts

    render 'users/show'
  end

  def tag
    @user = current_user

    @bookmarks = current_user.bookmarks.public_bookmarks
        .tagged_with(params[:tag], :any => true)
        .paginate(:page => params[:page])

    @tags = current_user.bookmarks.tag_counts
    
    render 'users/show'
  end

  def make_public
    params[:bookmark_ids].each do |bookmark_id|
      @bookmark = current_user.bookmarks.find(bookmark_id)
      @bookmark.private = false
      @bookmark.save
    end

    show
  end
end