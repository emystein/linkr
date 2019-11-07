class TagBundle < ApplicationRecord
  belongs_to :user
  validates_presence_of :name
  has_many :bundled_tags
  has_many :tags, through: :bundled_tags

  def tag_names
    self.tags.collect{|t| t.name}.join(',')
  end

  def bookmarks
    tag_names = self.tags.collect{|t| t.name}
    self.user.bookmarks.tagged_with(tag_names, :any => true)
  end
end
