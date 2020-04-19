Rails.application.routes.draw do
  root :to => "explore#index"

  devise_for :user
  
  devise_scope :user do
    post "/sessions/user", to: "devise/sessions#create" # devise post to this url on login
  end
  
  get "/explore"                      => "explore#index"
  get "/help"                         => "pages#help"
  get "/dashboard"                    => "dashboard#show"
  get "/dashboard/tags/:tag"          => "dashboard#tag"
  post "/dashboard/execute-actions"   => "dashboard#execute_actions"
  get "/inbox"                        => "inbox#index"

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

  get 'notification_control_center'                    => 'notification_control_center#index'
  post 'notification_control_center/notify'            => 'notification_control_center#notify'
end
