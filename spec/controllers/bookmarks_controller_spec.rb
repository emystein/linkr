require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe BookmarksController, :type => :controller do
  sign_me_in

  before :each do
    @location = Location.create!(url: "La URL")
  end

  # This should return the minimal set of attributes required to create a valid
  # Bookmark. As you add validations to Bookmark, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {"user_id" => subject.current_user.id, "title" => "El título", "url" => "La URL", "location_id" => @location.id}
  end

  describe "GET index" do
    it "assigns all bookmarks as @bookmarks" do
      bookmark = Bookmark.create! valid_attributes
      get :index
      assigns(:bookmarks).should eq([bookmark])
    end
  end

  describe "GET show" do
    it "assigns the requested bookmark as @bookmark" do
      bookmark = Bookmark.create! valid_attributes
      get :show, :params => {id: bookmark.id.to_s}
      assigns(:bookmark).should eq(bookmark)
    end
  end

  describe "GET new" do
    it "assigns a new bookmark as @bookmark" do
      get :new
      assigns(:bookmark).should be_a_new(Bookmark)
    end
  end

  describe "GET edit" do
    it "assigns the requested bookmark as @bookmark" do
      bookmark = Bookmark.create! valid_attributes
      get :edit, :params => {id: bookmark.id.to_s}
      assigns(:bookmark).should eq(bookmark)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Bookmark" do
        expect {
          post :create, :params => {bookmark: valid_attributes}
        }.to change(Bookmark, :count).by(1)
      end

      it "assigns a newly created bookmark as @bookmark" do
        post :create, :params => {bookmark: valid_attributes}
        assigns(:bookmark).should be_a(Bookmark)
        assigns(:bookmark).should be_persisted
      end

      it "redirects to the dashboard" do
        post :create, :params => {bookmark: valid_attributes}
        response.should redirect_to(dashboard_url)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved bookmark as @bookmark" do
        # Trigger the behavior that occurs when invalid params are submitted
        Bookmark.any_instance.stub(:save).and_return(false)
        post :create, :params => {bookmark: {}}
        assigns(:bookmark).should be_a_new(Bookmark)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Bookmark.any_instance.stub(:save).and_return(false)
        post :create, :params => {bookmark: {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested bookmark" do
        bookmark = Bookmark.create! valid_attributes
        # Assuming there are no other bookmarks in the database, this
        # specifies that the Bookmark created on the previous line
        # receives the :update message with whatever params are
        # submitted in the request.
        Bookmark.any_instance.should_receive(:update).with({'these' => 'params'})
        put :update, :params => {id: bookmark.id, bookmark: {'these' => 'params'}}
      end

      it "assigns the requested bookmark as @bookmark" do
        bookmark = Bookmark.create! valid_attributes
        put :update, :params => {id: bookmark.id, bookmark: valid_attributes}
        assigns(:bookmark).should eq(bookmark)
      end

      it "redirects to the dashboard" do
        bookmark = Bookmark.create! valid_attributes
        put :update, :params => {id: bookmark.id, bookmark: valid_attributes}
        response.should redirect_to(dashboard_url)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested bookmark" do
      bookmark = Bookmark.create! valid_attributes
      expect {
        delete :destroy, :params => {id: bookmark.id.to_s}
      }.to change(Bookmark, :count).by(-1)
    end

    it "redirects to the bookmarks list" do
      bookmark = Bookmark.create! valid_attributes
      delete :destroy, :params => {id: bookmark.id.to_s}
      response.should redirect_to(bookmarks_url)
    end
  end

end
