# frozen_string_literal: true

require 'rails_helper'

describe 'Help', type: :feature do
  before :each do
    @user = create(:user)
    visit new_user_session_path
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
    visit dashboard_path
  end

  it 'points to bookmarklet' do
    visit help_path
    expect(page).to have_content('drag this bookmarklet to your bookmark bar: save to linkr')
  end
end
