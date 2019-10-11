class UserDashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @bookmarks = current_user.bookmarks.paginate(:page => params[:page])
  end
end
