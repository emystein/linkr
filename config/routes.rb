Rails.application.routes.draw do
  get 'explore/index'
  devise_for :user, path_names: { sign_up: "signup", sign_in: "login", sign_out: "logout" }

  devise_scope :user do
    post "/sessions/user", to: "devise/sessions#create" # devise post to this url on login
  end

  get "/help"                         => "pages#help"
  get "/dashboard"                    => "dashboard#show"
  get "/dashboard/tags/:tag"          => "dashboard#tag"
  post "/dashboard/execute-actions"   => "dashboard#execute_actions"

  resources :users, :only => [:new, :create, :show, :update] do
    member do
      get :tags
    end
  end

  resources :sessions, :only => [:new, :create, :destroy]
  resources :tags, :only => [:index, :show]
  resources :tag_bundles

  resources :bookmarks do
    get :bookmarklet, :export, :on => :collection
    post :import, :on => :collection
  end

  resources :bookmarks_import
  resources :bookmarks_export

  root :to => "explore#index"
end
