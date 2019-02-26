class Location < ActiveRecord::Base
  has_many :bookmarks
  default_scope { order(created_at: :desc) }

  validates_presence_of :url
end
