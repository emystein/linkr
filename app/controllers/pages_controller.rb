# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    redirect_to :dashboard if current_user
  end
end
