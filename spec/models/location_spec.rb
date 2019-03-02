require 'spec_helper'

describe Location, type: :model do
  before do
    @location = create(:location)
  end

  it { should validate_presence_of(:url) }
end
