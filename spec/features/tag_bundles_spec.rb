require 'rails_helper'

describe "Tag Bundles", :type => :feature do
  before :each do
    @tag1 = create(:tag)
    @tag2 = create(:tag)

    @user = create(:user)
    visit new_user_session_path
    fill_in "Email", :with => @user.email
    fill_in "Password", :with => "password"
    click_button "Log in"
  end
  
  it "create a Tag Bundle" do
    visit new_tag_bundle_path
    fill_in 'Name', with: 'Tag Bundle 1'
    fill_in 'Tags', with: 'tag1, tag2'
    click_button 'Save'

    expect(page).to have_content('Tag Bundle 1')
    expect(page).to have_content('tag1')
    expect(page).to have_content('tag2')
  end
  
  it "list Tag Bundles" do
    tag_bundle_1 = TagBundle.create(user: @user, name: 'Tag Bundle 1', tags: [@tag1])
    tag_bundle_2 = TagBundle.create(user: @user, name: 'Tag Bundle 2', tags: [@tag2])

    visit tag_bundles_path

    expect(page).to have_content('Tag Bundle 1')
    expect(page).to have_content(@tag1.name)
    expect(page).to have_content('Tag Bundle 2')
    expect(page).to have_content(@tag2.name)
  end

  it "edit Tag Bundle from list" do
    tag_bundle_1 = TagBundle.create(user: @user, name: 'Tag Bundle 1', tags: [@tag1])

    visit tag_bundles_path

    click_link 'Edit'

    expect(page.current_path).to eq edit_tag_bundle_path(tag_bundle_1.id)
  end

  it "update a Tag Bundle" do
    visit new_tag_bundle_path
    fill_in 'Name', with: 'Tag Bundle 1'
    fill_in 'Tags', with: 'tag1'
    click_button 'Save'

    visit edit_tag_bundle_path('1')

    fill_in 'Tags', with: 'tag1, tag2'
    click_button 'Save'

    expect(page).to have_content('Tag Bundle 1')
    expect(page).to have_content('tag1')
    expect(page).to have_content('tag2')
  end

  it "delete Tag Bundle" do
    tag_bundle_1 = TagBundle.create(user: @user, name: 'Tag Bundle 1', tags: [@tag1])

    visit tag_bundles_path

    click_link 'Delete'

    expect(page).to_not have_content('Tag Bundle 1')
  end
end
