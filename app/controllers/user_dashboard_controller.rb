class UserDashboardController < ApplicationController
  before_action :authenticate_user!, :assign_common_fields

  def assign_common_fields
    @user = current_user
    @tags = current_user.bookmarks.tag_counts
  end

  def show
    @bookmarks = current_user.bookmarks.paginate(:page => params[:page])
    render 'users/show'
  end

  def tag
    @bookmarks = current_user.bookmarks.public_bookmarks
        .tagged_with(params[:tag], :any => true)
        .paginate(:page => params[:page])
    render 'users/show'
  end

  def actions
    logger.info("Executing action: #{params[:commit]}")

    commands_by_key = { 
      'make_private' => TogglePrivateBookmarksCommand,
      'make_public' => TogglePublicBookmarksCommand,
      'delete' => DeleteBookmarksCommand,
      'add_tag' => AddTagToBookmarksCommand,
    }

    command = commands_by_key[params[:commit]].new(current_user)

    command.apply(params[:bookmark_ids] ||= [], params)

    redirect_to action: :show
  end
end

class UserBookmarksCommand
  def initialize(current_user)
    @current_user = current_user
  end
end

class BookmarkVisibilityToggleCommand
  def initialize(current_user)
    @current_user = current_user
  end

  def toggle_private(bookmark_ids, toggle)
    bookmark_ids.each do |bookmark_id|
      bookmark = @current_user.bookmarks.find(bookmark_id)
      bookmark.private = toggle
      bookmark.save
    end
  end
end

class TogglePrivateBookmarksCommand < BookmarkVisibilityToggleCommand
  def apply(bookmark_ids, params)
    toggle_private(bookmark_ids, true)
  end
end

class TogglePublicBookmarksCommand < BookmarkVisibilityToggleCommand
  def apply(bookmark_ids, params)
    toggle_private(bookmark_ids, false)
  end
end

class DeleteBookmarksCommand < UserBookmarksCommand
  def apply(bookmark_ids, params)
    bookmark_ids.each do |bookmark_id|
      @current_user.bookmarks.delete(bookmark_id)
    end
  end
end

class AddTagToBookmarksCommand < UserBookmarksCommand
  def apply(bookmark_ids, params)
    bookmark_ids.each do |bookmark_id|
      bookmark = @current_user.bookmarks.find(bookmark_id)
      bookmark.tag_list.add(params[:tag])
      bookmark.save
    end
  end
end