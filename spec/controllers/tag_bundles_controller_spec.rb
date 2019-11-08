require "rails_helper"

RSpec.describe TagBundlesController, type: :controller do
  sign_me_in

  before do
    @tag1 = create(:tag)
    @tag2 = create(:tag)
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new tag bundle" do
        post :create, :params => { name: 'name', tags: "#{@tag1.name}, #{@tag2.name}" }

        expect(assigns(:tag_bundle).tags).to eq [@tag1, @tag2]
      end
    end
  end

  describe "GET show" do
    it "shows bookmarks associated to tags" do
        bookmark = create(:bookmark)
        bookmark.tag_list.add(@tag1.name)
        bookmark.save

        tag_bundle = TagBundle.create(user: subject.current_user, name: 'tag_bundle1', tags: [@tag1])

        get :show, :params => {id: tag_bundle.id}

        expect(assigns(:bookmarks)).to contain_exactly(bookmark)
    end 
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested tag bundle" do
        tag_bundle = TagBundle.create(user: subject.current_user, name: 'tag_bundle1', tags: [@tag1])

        allow_any_instance_of(TagBundle).to receive(:update).with({ :name => "updated name", :tags => [@tag1, @tag2] })

        put :update, :params => { id: tag_bundle.id, name: "updated name", tags: "#{@tag1.name},#{@tag2.name}" }

        # TODO fix
        # expect(response).to redirect_to(tag_bundles_url)
      end
      it "add tag if not exist" do
        tag_bundle = TagBundle.create(user: subject.current_user, name: 'tag_bundle1', tags: [@tag1])

        put :update, :params => { id: tag_bundle.id, name: "updated name", tags: "#{@tag1.name},new_tag" }

        expect(assigns(:tag_bundle).tags.collect{|t| t.name}).to eq [@tag1.name, 'new_tag']
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested tag_bundle" do
      tag_bundle = TagBundle.create(user: subject.current_user, name: 'tag_bundle1', tags: [@tag1])
      expect {
        delete :destroy, :params => { id: tag_bundle.id.to_s }
      }.to change(TagBundle, :count).by(-1)
    end

    it "redirects to the tag_bundles list" do
      tag_bundle = TagBundle.create(user: subject.current_user, name: 'tag_bundle1', tags: [@tag1])
      delete :destroy, :params => { id: tag_bundle.id.to_s }
      expect(response).to redirect_to(tag_bundles_url)
    end
  end
end
