require "rails_helper"

describe DashboardController, :type => :controller do
  sign_me_in

  describe "GET 'show'" do
    it "should be successful" do
      get "show"
      expect(response).to be_successful
    end
  end
end
