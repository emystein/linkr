# frozen_string_literal: true

require 'rails_helper'

describe 'Help', type: :feature do
  it 'points to bookmarklet' do
    visit help_path
    expect(page).to have_content('drag this bookmarklet to your bookmark bar: save to linkr')
  end
end
