class TagBundle < ApplicationRecord
  belongs_to :user
  validates_presence_of :name
  has_many :bundled_tags
  has_many :tags, through: :bundled_tags

  def tag_names
    self.tags.collect{|t| t.name}
  end

  def bookmarks
    self.user.bookmarks.tagged_with(self.tag_names, :any => true)
  end
end
