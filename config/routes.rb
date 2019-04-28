Rails.application.routes.draw do
  devise_for :user, path_names: { sign_up: "signup", sign_in: "login", sign_out: "logout" }

  devise_scope :user do
    post "/sessions/user", to: "devise/sessions#create" # devise post to this url on login
  end

  get "/help" => "pages#help"
  get "/dashboard" => "dashboard#show"

  resources :users, :only => [:new, :create, :show, :update]
  get "/users/:id/tags" => "users#tags"

  resources :sessions, :only => [:new, :create, :destroy]
  resources :tags, :only => [:index, :show]

  resources :bookmarks do
    get :save, :on => :member
    get :bookmarklet, :on => :collection
  end

  root :to => "dashboard#show"
end
