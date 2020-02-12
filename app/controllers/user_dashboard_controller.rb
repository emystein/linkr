class UserDashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @bookmarks = current_user.bookmarks.paginate(:page => params[:page])
    @tags = current_user.bookmarks.tag_counts

    render 'users/show'
  end

  def tag
    @user = current_user

    @bookmarks = current_user.bookmarks.public_bookmarks
        .tagged_with(params[:tag], :any => true)
        .paginate(:page => params[:page])

    @tags = current_user.bookmarks.tag_counts
    
    render 'users/show'
  end

  def actions
    logger.info("Executing action: #{params[:commit]}")

    bookmark_ids = params[:bookmark_ids] ? params[:bookmark_ids] : []

    commands_by_key = { 
      'make_private' => TogglePrivateBookmarksCommand,
      'make_public' => TogglePublicBookmarksCommand,
      'delete' => DeleteBookmarksCommand,
      'add_tag' => AddTagToBookmarksCommand,
    }

    command_class = commands_by_key[params[:commit]]

    command = command_class.new(current_user)

    command.apply(bookmark_ids, params)

    redirect_to action: :show
  end
end

class BookmarkVisibilityToggle
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

class TogglePrivateBookmarksCommand
  def initialize(current_user)
    @visibility_toggle = BookmarkVisibilityToggle.new(current_user)
  end

  def apply(bookmark_ids, params)
    @visibility_toggle.toggle_private(bookmark_ids, true)
  end
end

class TogglePublicBookmarksCommand 
  def initialize(current_user)
    @visibility_toggle = BookmarkVisibilityToggle.new(current_user)
  end

  def apply(bookmark_ids, params)
    @visibility_toggle.toggle_private(bookmark_ids, false)
  end
end

class DeleteBookmarksCommand 
  def initialize(current_user)
    @current_user = current_user
  end

  def apply(bookmark_ids, params)
    bookmark_ids.each do |bookmark_id|
      @current_user.bookmarks.delete(bookmark_id)
    end
  end
end

class AddTagToBookmarksCommand
  def initialize(current_user)
    @current_user = current_user
  end

  def apply(bookmark_ids, params)
    bookmark_ids.each do |bookmark_id|
      bookmark = @current_user.bookmarks.find(bookmark_id)
      bookmark.tag_list.add(params[:tag])
      bookmark.save
    end
  end
end