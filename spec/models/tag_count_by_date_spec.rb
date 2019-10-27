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

  it 'tags are sorted by date and count' do
    tag_count_by_date = TagCountByDate.all

    expect(tag_count_by_date.map{|t| t.name}).to eq ['tag1', 'tag2', 'tag3']
  end

  it 'retrieve last week' do
    tag_count_by_date = TagCountByDate.all.where('created_at >= ?', 1.week.ago)

    expect(tag_count_by_date.count).to eq 3
  end

  describe 'Subset' do
    it 'take less than the total of tags' do
      tag_count_by_date = TagCountByDate.all.take(2)

      expect(tag_count_by_date.map{|t| t.name}).to eq ['tag1', 'tag2']
    end

    it 'take more than the total of tags' do
      tag_count_by_date = TagCountByDate.all.take(4)

      expect(tag_count_by_date.map{|t| t.name}).to eq ['tag1', 'tag2', 'tag3']
    end
  end
end
