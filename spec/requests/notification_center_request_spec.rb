require 'rails_helper'

RSpec.describe "NotificationControlCenter", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/notification_control_center"
      expect(response).to have_http_status(:success)
    end
  end
end
