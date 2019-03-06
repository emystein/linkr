require 'active_support/concern'

module BookmarkExtension extend ActiveSupport::Concern
  class_methods do
    def search(query)
      Bookmark.where('lower(title) like lower(?)', "%#{query}%") 
    end
  end
end

class Bookmark < ActiveRecord::Base
  include BookmarkExtension

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
end
