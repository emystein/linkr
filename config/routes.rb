Rails.application.routes.draw do
  devise_for :user, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    post "/sessions/user", to: "devise/sessions#create" # devise post to this url on login
  end

  get "/explore"                      => "explore#index"
  get "/help"                         => "pages#help"
  get "/dashboard"                    => "dashboard#show"
  get "/dashboard/tags/:tag"          => "dashboard#tag"
  post "/dashboard/execute-actions"   => "dashboard#execute_actions"

  resources :users, :only => [:new, :create, :show, :update] do
    member do
      get :tags
    end
  end

  # resources :sessions, :only => [:new, :create, :destroy]

  resources :tags, :only => [:index, :show]

  resources :tag_bundles

  resources :bookmarks do
    get :bookmarklet, :import_form, :export_form, :export, :on => :collection
    post :import, :on => :collection
  end

  root :to => "explore#index"
end
