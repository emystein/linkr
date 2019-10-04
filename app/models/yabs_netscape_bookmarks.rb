require "nokogiri"

# See http://joshorourke.com/2012/06/28/parsing-bookmarks-with-nokogiri
class YabsNetscapeBookmarks
  include Enumerable

  def self.import(user, path)
    bookmarks = YabsNetscapeBookmarks.new(user, path)
    BookmarksImport.import(bookmarks)
  end

  def initialize(user, path)
    @user = user
    @path = path
  end

  def each
    doc  = Nokogiri::HTML(File.open(@path))
    node = doc.at_xpath('//html/body')
    traverse(node, '/') { |b| yield b }
  end

  private

  def traverse(node, path, &block)
    anchors = node.search('./dt//a')
    folder_names = node.search('./dt/h3')
    folder_items = node.search('./dl')

    anchors.each do |anchor|
      bookmark = Bookmark.new(user: @user, title: anchor.text, url: anchor['href'], private: anchor['private'] != '0')
      bookmark.tag_list.add(anchor['tags'], parse: true)
      yield bookmark
    end

    folder_items.size.times do |i|
      folder_name = folder_names[i]
      folder_item = folder_items[i]
      next_path   = folder_name.nil? ? path : [path, folder_name].join('/')
      traverse(folder_item, next_path, &block)
    end
  end
end
