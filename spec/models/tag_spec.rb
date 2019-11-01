require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'create a Tag' do
    tag = Tag.create(name: 'tag1')

    expect(Tag.find(tag.id)).to be_present
  end
end
