require 'spec_helper'

describe Bookmark, type: :model do
  before do
    @user = create(:user)
    @location = create(:location) 
    @bookmark = create(:bookmark)
  end

  it { should validate_presence_of(:title) }

end
