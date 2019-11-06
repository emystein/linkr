require 'rails_helper'

RSpec.describe Tags, type: :model do
  it 'create Tags' do
    tags = Tags.from_names('tag1,tag2')

    expect(tags[0].name).to eq 'tag1'
    expect(tags[1].name).to eq 'tag2'
  end
end
