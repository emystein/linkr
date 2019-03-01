require 'spec_helper'

describe DashboardController, :type => :controller do
  sign_me_in

  describe "GET 'show'" do
    it "should be successful" do
      get 'show'
      response.should be_success
    end
  end

end
