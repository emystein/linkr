class BookmarksController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index]

  @@csv_metadata_by_format = {'yabs' => YabsCsvMetadata}
  @@bookmark_factory_by_format = {'yabs' => YabsBookmark}

  def index
    if params[:search_query]
      @bookmarks = Bookmark.public_bookmarks.search(params[:search_query]).paginate(:page => params[:page])
    else
      @bookmarks = Bookmark.public_bookmarks.paginate(:page => params[:page])
    end
  end

  def show
    @bookmark = Bookmark.find(params[:id])
  end

  def new
    @bookmark = current_user.bookmarks.new(:title => params[:title], :url => params[:url])
  end

  def save
    original_bookmark = Bookmark.find(params[:id])
    @bookmark = original_bookmark.dup
    @bookmark.tag_list = original_bookmark.tag_list
    render :new
  end

  def bookmarklet
    @bookmark = current_user.bookmarks.new(:title => params[:title], :url => params[:url])
    render :layout => "minimal"
  end

  def edit
    @bookmark = current_user.bookmarks.find(params[:id])
  end

  def create
    params.permit!
    @bookmark = current_user.bookmarks.new(params[:bookmark])

    if @bookmark.save
      redirect_to dashboard_url, :flash => {:success => 'Bookmark was successfully created.'}
    else
      render action: "new"
    end
  end

  def update
    params.permit!
    @bookmark = current_user.bookmarks.find(params[:id])

    updated = @bookmark.update(params[:bookmark])
    
    if updated
      redirect_to dashboard_url, :flash => {:success => 'Bookmark was successfully updated.'}
    else
      render action: "edit"
    end
  end

  def destroy
    @bookmark = current_user.bookmarks.find(params[:id])
    @bookmark.destroy

    redirect_to bookmarks_url
  end

  def bookmarks_params
    params.permit(:search_query)
  end

  def show_import_form
    render 'import'
  end

  def import
    import_format = params[:import_format]

    import_start_timestamp = Time.now

    if @@csv_metadata_by_format.has_key?(import_format)
      BookmarksCsv.import(params[:file], 
                          @@csv_metadata_by_format[import_format], 
                          @@bookmark_factory_by_format[import_format].new(current_user))
    else
      @error_message = "Import format not recognized: #{import_format}"
    end

    @bookmarks = Bookmark.where(:created_at => import_start_timestamp..Time.now)

    render 'import_results'
  end
end
