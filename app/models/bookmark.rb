class Bookmark < ActiveRecord::Base
  attr_accessor :url

  acts_as_taggable_on :tags

  default_scope { order(created_at: :desc) }
  scope :public_bookmarks, -> { where(private: false) }

  belongs_to :location
  belongs_to :user

  delegate :url, to: :location, allow_nil: true

  validates_presence_of :title

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

  require 'smarter_csv'

  def self.yabs_csv_import(user, csv_file)
    bookmarks = []

    rows = SmarterCSV.process(csv_file.path)

    rows = rows.filter { |row| row[:id].is_a? Numeric }

    transaction do
      rows.each do |row|
        next if Location.where(url: row[:link]).exists?

        bookmarks << save_bookmark_from_csv_row(row, user)
      end
    end

    bookmarks
  end

  def self.save_bookmark_from_csv_row(row, user)
    bookmark = Bookmark.new(user: user, title: row[:title], url: row[:link], private: row[:state] != 'public')
    bookmark.tag_list.add(row[:tags], parse: true)
    bookmark.save
    bookmark
  end
end
