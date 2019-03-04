require 'rails_helper'

describe TagsController, :type => :controller do

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get 'show', :params => {:id => "music"}
      response.should be_success
    end
  end

end
