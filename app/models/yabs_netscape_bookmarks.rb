require "nokogiri"

class YabsNetscapeBookmarks
  include Enumerable

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
      yield Bookmark.new(user: @user, title: anchor.text, url: anchor["href"])
    end

    folder_items.size.times do |i|
      folder_name = folder_names[i]
      folder_item = folder_items[i]
      next_path   = folder_name.nil? ? path : [path, folder_name].join('/')
      traverse(folder_item, next_path, &block)
    end
  end
end
