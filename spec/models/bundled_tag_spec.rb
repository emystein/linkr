require 'rails_helper'

RSpec.describe BundledTag, type: :model do
  before do
    @user = create(:user)
    @tag = create(:tag)
  end

  it 'creates a BundledTag' do
    tag_bundle = TagBundle.create(user: @user, name: 'tag_bundle1')

    bundle_tag = BundledTag.create(tag_bundle: tag_bundle, tag: @tag)

    expect(BundledTag.find(bundle_tag.id)).to be_present
  end
end
