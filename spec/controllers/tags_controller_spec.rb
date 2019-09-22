require "rails_helper"

describe TagsController, :type => :controller do
  describe "GET 'index'" do
    it "should be successful" do
      get "index"
      expect(response).to be_successful
    end
  end

  describe "GET 'show'" do
    it "should be successful" do
      get "show", :params => { :id => "music" }
      expect(response).to be_successful
    end
  end
end
