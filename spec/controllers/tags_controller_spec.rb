# frozen_string_literal: true

require 'rails_helper'

describe TagsController, type: :controller do
  describe "GET 'index' not logged in" do
    it 'should be successful' do
      get :index

      expect(response).to be_successful
      expect(assigns(:user_tags)).to be_empty
    end
  end

  describe "GET 'index' logged in" do
    sign_me_in

    it 'should be successful' do
      get :index

      expect(response).to be_successful
      expect(assigns(:user_tags)).to eq(subject.current_user.bookmarks.tag_counts)
    end
  end

  describe "GET 'show'" do
    it 'should be successful' do
      get :show, params: { id: 'music' }

      expect(response).to be_successful
    end
  end
end
