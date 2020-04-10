class BookmarksController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index]

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
      redirect_to dashboard_url, :flash => { :success => "Bookmark was successfully created." }
    else
      render action: "new"
    end
  end

  def update
    params.permit!
    @bookmark = current_user.bookmarks.find(params[:id])

    updated = @bookmark.update(params[:bookmark])

    if updated
      redirect_to dashboard_url, :flash => { :success => "Bookmark was successfully updated." }
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

  def import
    bookmark_imports = { 
      "yabs_csv" => YabsCsvBookmarks, 
      "yabs_netscape" => YabsNetscapeBookmarks 
    }
    
    import_format = params[:import_format]
    
    begin
      @bookmarks = bookmark_imports[import_format].import(current_user, params[:file].path)
      flash[:success] = "Total bookmarks imported: #{@bookmarks.count}"
    rescue NoMethodError
      @bookmarks = []
      flash[:error] = "Import format not defined: #{import_format}"
    end
    
    redirect_to dashboard_url
  end
  
  def export
    document = NetscapeBookmarks.create_document(current_user.bookmarks)
    send_data(document, :filename => 'bookmarks.html')
  end
end
