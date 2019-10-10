class UserDashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @bookmarks = current_user.bookmarks.paginate(:page => params[:page])
  end
end
