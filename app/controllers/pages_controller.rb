class PagesController < ApplicationController
  before_action :authenticate_user!, :except => [:help]

  def index
    redirect_to :dashboard if current_user
  end

  def help
  end

end
