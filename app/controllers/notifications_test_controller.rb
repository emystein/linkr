class NotificationsTestController < ApplicationController
  def index
    notification = Notification.new
    notification.target = User.first
    notification.metadata = {
      title: "My first notification",
      content: "It looks great, doesn't it?",
    }
    # notification.object = Bookmark.first
    notification.save
  end
end
