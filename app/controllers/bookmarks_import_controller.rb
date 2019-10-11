class BookmarksImportController < ApplicationController
  before_action :authenticate_user!

  @@bookmark_imports = { 
    "yabs_csv" => YabsCsvBookmarks, 
    "yabs_netscape" => YabsNetscapeBookmarks 
  }

  def create
    import_format = params[:import_format]

    begin
      @bookmarks = @@bookmark_imports[import_format].import(current_user, params[:file].path)
      flash[:success] = "Total bookmarks imported: #{@bookmarks.count}"
    rescue NoMethodError
      @bookmarks = []
      flash[:error] = "Import format not defined: #{import_format}"
    end

    redirect_to user_path(current_user)
  end
end
