class Bookmark < ActiveRecord::Base
  attr_accessor :url
  belongs_to :location
  belongs_to :user
  delegate :url, to: :location, allow_nil: true
  acts_as_taggable_on :tags

  default_scope { order(created_at: :desc) }
  scope :public_bookmarks, -> { where(private: false) }
  scope :private_bookmarks, -> { where(private: true) }

  validates_presence_of :title
  validates_uniqueness_of :location, scope: :user

  before_validation(on: :create) do
    find_or_generate_location
  end

  def find_or_generate_location
    self.location = Location.find_or_create_by(url: @url)
  end

  # see also: https://www.justinweiss.com/articles/search-and-filter-rails-models-without-bloating-your-controller/
  def self.search(query)
    where('lower(title) like lower(?)', "%#{query}%")
  end

  notification_object
end
