class Bookmark < ActiveRecord::Base
  attr_accessor :url

  acts_as_taggable_on :tags

  default_scope { order(created_at: :desc) }
  scope :public_bookmarks, -> { where(:private => false) }

  belongs_to  :location
  belongs_to  :user

  delegate :url, :to => :location, :allow_nil => true

  before_validation(on: :create) do
    find_or_generate_location 
  end

  validates_presence_of :title

  def find_or_generate_location
    logger.info "Finding location with URL #{@url}"
    self.location = Location.find_or_create_by(:url => @url)
    logger.info "Set location #{self.location}"
  end
end
