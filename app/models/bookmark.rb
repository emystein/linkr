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

  require 'smarter_csv'

  def self.yabs_csv_import(user, file)
    bookmarks = []

    rows = SmarterCSV.process(file.path)

    # Skip row with summary 'Generated on:...'
    rows = rows.filter { |row| row[:id].is_a? Integer }

    transaction do
      rows.each do |row|
        if !Location.where(:url => row[:link]).exists? then
          bookmark = Bookmark.new(user: user, title: row[:title], url: row[:link], private: row[:state] != 'public')
          # bookmark = Bookmark.where(location.url: row[:link]).first_or_create(user: user, title: row[:title], url: row[:link], private: row[:state] != 'public')
          bookmark.tag_list.add(row[:tags], parse: true)
          bookmark.save
          bookmarks << bookmark
        end
      end
    end

    # TODO: add pagination
    # bookmark_ids = bookmarks.map { |bookmark| bookmark.id }
    # bookmarks = Bookmark.where(:id => bookmark_ids).paginate(:page => params[:page])

    bookmarks
  end
end
