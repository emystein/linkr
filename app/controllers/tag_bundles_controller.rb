class TagBundlesController < ApplicationController
  before_action :authenticate_user!

  def index
    @tag_bundles = current_user.tag_bundles.paginate(:page => params[:page])
  end

  def create
    params.permit!

    tags = Tags.from_names(params[:tags])

    @tag_bundle = TagBundle.create!(user: current_user, name: params[:name], tags: tags)

    redirect_to tag_bundles_path
  end

  def show
    @tag_bundle = find(params[:id])
    @bookmarks = @tag_bundle.bookmarks.paginate(:page => params[:page])
  end

  def edit
    @tag_bundle = find(params[:id])
  end

  def update
    params.permit!

    @tag_bundle = find(params[:id])

    tags = Tags.from_names(params[:tags])

    updated = @tag_bundle.update(name: params[:name], tags: tags)

    if updated
      redirect_to tag_bundles_url, :flash => { :success => "Tag Bundle was successfully updated." }
    else
      render action: "edit"
    end
  end

  def destroy
    find(params[:id]).destroy

    redirect_to tag_bundles_url
  end

  def find(id)
    current_user.tag_bundles.find(id)
  end
end
