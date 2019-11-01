require 'rails_helper'

RSpec.describe TagBundle, type: :model do
  before do
    @user = create(:user)
    @tag1 = create(:tag)
    @tag2 = create(:tag)
  end

  it 'creates a TagBundle' do
    tag_bundle = TagBundle.create(user: @user, name: 'tag_bundle1', tags: [@tag1, @tag2])

    expect(TagBundle.find(tag_bundle.id)).to be_present
  end

  it 'assigns TagBundle to User' do
    tag_bundle = TagBundle.create(user: @user, name: 'tag_bundle1', tags: [@tag1, @tag2])

    @user.tag_bundles << tag_bundle
    @user.save

    expect(User.find(@user.id).tag_bundles).to eq [tag_bundle]
  end
end
