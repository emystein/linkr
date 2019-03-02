class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by_id(params[:id])
    @bookmarks = @user.bookmarks.public_bookmarks.paginate(:page => params[:page])
  end
end
