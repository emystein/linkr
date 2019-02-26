class DashboardController < ApplicationController
  before_action :require_user

  def show
    @bookmarks = current_user.bookmarks.paginate(:page => params[:page])
  end
end
