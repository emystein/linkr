class NotificationControlCenterController < ApplicationController
  def notify
    user = User.find_by_nickname(params[:username])

    if (!params[:bookmark_id].empty?) then
      bookmark = Bookmark.find_by_id(params[:bookmark_id])
      user.notify(type: 'bookmark', object: bookmark)
    else
      user.notify(type: 'notification', metadata: {title: "Notification", content: params[:notification_text]})
    end
  end
end
