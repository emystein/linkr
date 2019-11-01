require 'rails_helper'

RSpec.describe TagBundle, type: :model do
  before do
    @user = create(:user)
  end

  it 'creates a TagBundle' do
    tag1 = Tag.create(name: 'tag1')
    tag2 = Tag.create(name: 'tag2')

    tag_bundle = TagBundle.create(user: @user, name: 'tag_bundle1')
    tag_bundle.tags = [tag1, tag2]
    tag_bundle.save
  end
end
