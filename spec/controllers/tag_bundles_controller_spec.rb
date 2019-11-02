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

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested tag bundle" do
        tag_bundle = TagBundle.create(user: subject.current_user, name: 'tag_bundle1', tags: [@tag1])

        allow_any_instance_of(TagBundle).to receive(:update).with({ :name => "updated name", :tags => [@tag1, @tag2] })

        put :update, :params => { id: tag_bundle.id, name: "updated name", tags: "#{@tag1.name},#{@tag2.name}" }
      end
    end
  end
end
