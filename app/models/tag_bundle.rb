class TagBundle < ApplicationRecord
  belongs_to :user
  validates_presence_of :name
  has_many :bundled_tags
  has_many :tags, through: :bundled_tags
end
