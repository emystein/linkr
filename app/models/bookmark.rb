class Bookmark < ActiveRecord::Base
  attr_accessor :url

  acts_as_taggable_on :tags

  default_scope { order(created_at: :desc) }
  scope :public_bookmarks, -> { where(:private => false) }

  belongs_to :location
  belongs_to :user

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
    self.where("lower(title) like lower(?)", "%#{query}%")
  end

  require 'csv'
  require 'activerecord-import/base'

  def self.yabs_csv_import(file, user)
    bookmarks = []
    CSV.foreach(file.path, headers: true) do |row|
      bookmark = Bookmark.new(user: user, title: row[4], url: row[5])
      bookmarks << bookmark
    end
    Bookmark.import bookmarks, recursive: true
  end
end
