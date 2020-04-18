require 'rails_helper'

RSpec.describe "NotificationsTests", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/notifications_test/index"
      expect(response).to have_http_status(:success)
    end
  end

end
