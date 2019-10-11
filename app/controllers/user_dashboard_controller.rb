class UserDashboardController < ApplicationController
  before_action :authenticate_user!

  def tag
    @user = current_user

    @bookmarks = current_user.bookmarks.public_bookmarks
        .tagged_with(params[:tag], :any => true)
        .paginate(:page => params[:page])

    @tags = current_user.bookmarks.tag_counts
    
    render 'users/show'
  end
end