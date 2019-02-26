Linkr::Application.routes.draw do
  get '/signup' => 'users#new'
  get '/login'  => 'sessions#new'
  get '/logout' => 'sessions#destroy'

  get '/help'      => 'pages#help'
  get '/dashboard' => 'dashboard#show'

  resources :users,    :only => [:new, :create, :show, :update]
  resources :sessions, :only => [:new, :create, :destroy]
  resources :tags, :only => [:index, :show]

  resources :bookmarks do
    get :save, :on => :member
    get :bookmarklet, :on => :collection
  end

  root :to => 'sessions#new'
end
