Rails.application.routes.draw do
  devise_for :user, path_names: { sign_up: "signup", sign_in: "login", sign_out: "logout" }

  devise_scope :user do
    post "/sessions/user", to: "devise/sessions#create" # devise post to this url on login
  end

  get "/help"             => "pages#help"
  get "/dashboard"        => "users#show"
  get "/dashboard/tags/:tag" => "user_dashboard#tag"

  resources :users, :only => [:new, :create, :show, :update] do
    member do
      get :tags
    end
  end

  resources :sessions, :only => [:new, :create, :destroy]
  resources :tags, :only => [:index, :show]

  resources :bookmarks do
    get :bookmarklet, :export, :on => :collection
    post :import, :on => :collection
  end

  resources :bookmarks_import
  resources :bookmarks_export

  root :to => "users#show"
end
