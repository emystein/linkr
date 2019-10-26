require 'rails_helper'

describe TagCountByDate, type: :model do
  before do
    user = create(:user)

    bookmark = user.bookmarks.create!(title: "Kitchen table", url: "Kitchen table URL")
    bookmark.tag_list.add("tag1", "tag2")
    bookmark.save

    bookmark = user.bookmarks.create!(title: "Dinner table", url: "Dinner table URL")
    bookmark.tag_list.add("tag1", "tag3")
    bookmark.save
  end

  it 'tag count by date is not empty' do
    tag_count_by_date = TagCountByDate.all

    expect(tag_count_by_date[0].name).to eq 'tag1'
    expect(tag_count_by_date[1].name).to eq 'tag2'
    expect(tag_count_by_date[2].name).to eq 'tag3'
  end
end
