require 'active_support/concern'

class Bookmark < ActiveRecord::Base
  attr_accessor :url

  acts_as_taggable_on :tags

  default_scope { order(created_at: :desc) }
  scope :public_bookmarks, -> { where(:private => false) }

  belongs_to  :location
  belongs_to  :user

  delegate :url, :to => :location, :allow_nil => true
  
  validates_presence_of :title

  before_validation(on: :create) do
    find_or_generate_location 
  end

  def find_or_generate_location
    self.location = Location.find_or_create_by(:url => @url)
  end

  # see also: https://www.justinweiss.com/articles/search-and-filter-rails-models-without-bloating-your-controller/
  def self.search(query)
    self.where('lower(title) like lower(?)', "%#{query}%") 
  end
end
