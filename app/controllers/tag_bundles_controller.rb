class TagBundlesController < ApplicationController
  before_action :authenticate_user!

  def index
    @tag_bundles = current_user.tag_bundles.paginate(:page => params[:page])
  end

  def create
    params.permit!

    tags = tags_from_names(params[:tags])

    @tag_bundle = TagBundle.create!(user: current_user, name: params[:name], tags: tags)
  end

  def show
    @tag_bundle = find(params[:id])
  end

  def edit
    @tag_bundle = find(params[:id])
  end

  def update
    params.permit!

    @tag_bundle = find(params[:id])

    tags = tags_from_names(params[:tags])

    updated = @tag_bundle.update(name: params[:name], tags: tags)

    if updated
      redirect_to dashboard_url, :flash => { :success => "Tag Bundle was successfully updated." }
    else
      render action: "edit"
    end
  end

  def destroy
    @tag_bundle = find(params[:id])
    @tag_bundle.destroy

    redirect_to tag_bundles_url
  end

  def tags_from_names(joined_tag_names)
    tag_names = joined_tag_names.split(',').map{ |n| n.strip}
    Tag.where(name: tag_names)
  end

  def find(id)
    current_user.tag_bundles.find(id)
  end
end
