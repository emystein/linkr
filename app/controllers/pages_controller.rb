class PagesController < ApplicationController
  before_action :require_user, :only => [:help]

  def index
    redirect_to :dashboard if current_user
  end

  def help
  end

end
