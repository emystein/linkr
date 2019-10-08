require "bookmarks"
include Bookmarks

class NetscapeBookmarks
  def self.map(bookmarks)
    bookmarks.map { |bookmark|
      NetscapeBookmark.new(
        url: bookmark.url,
        title: bookmark.title,
        date: bookmark.created_at,
        tags: bookmark.tag_list.to_s,
      )
    }
  end

  def self.create_document(bookmarks)
    export_bookmarks = map(bookmarks)

    document = Document.new

    document.build do
      export_bookmarks.each { |e| e }
    end

    document.document
  end
end
