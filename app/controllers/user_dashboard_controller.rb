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

  def actions
    logger.info("Action: #{params[:commit]}")

    bookmark_ids = params[:bookmark_ids]

    if params[:commit] == 'make_public'
        make_public(bookmark_ids)
    elsif params[:commit] == 'make_private'
        make_private(bookmark_ids)
    elsif params[:commit] == 'delete'
        delete(bookmark_ids)
    end
  end

  def make_public(bookmark_ids)
    toggle_public_private(bookmark_ids, false)
  end

  def make_private(bookmark_ids)
    toggle_public_private(bookmark_ids, true)
  end

  def toggle_public_private(bookmark_ids, toggle)
    bookmark_ids.each do |bookmark_id|
      @bookmark = current_user.bookmarks.find(bookmark_id)
      @bookmark.private = toggle
      @bookmark.save
    end
    show
  end

  def delete(bookmark_ids)
    bookmark_ids.each do |bookmark_id|
      current_user.bookmarks.delete(bookmark_id)
    end
    show
  end
end