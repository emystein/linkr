require 'rails_helper'

RSpec.describe BundledTag, type: :model do
  before do
    @user = create(:user)
  end

  it 'creates a BundledTag' do
    tag1 = Tag.create(name: 'tag1')
    tag2 = Tag.create(name: 'tag2')

    tag_bundle = TagBundle.create(user: @user, name: 'tag_bundle1')

    bundle_tag = BundledTag.create(tag_bundle: tag_bundle, tag: tag1)
  end
end
