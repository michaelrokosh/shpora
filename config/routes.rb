Shpora::Application.routes.draw do

  root 'home#index'

  get '/recent', to: 'pages#show', as: :recent_pages
  post ':user_id/favorites/:page_id', to: 'favorites#create', as: :new_favorite
  delete ':user_id/favorites/:page_id', to: 'favorites#destroy', as: :delete_favorite
  get ':user_id/favorites', to: 'favorites#index', as: :favorites
  get '/robots.txt', to: 'robots#robots'

  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }

  namespace :assets do
    resources :tags, only: :index
  end

  namespace :admin do
    resources :users, only: [:index, :show] do
      get :relogin, action: :relogin, on: :member
    end
  end

  resources :uploads, only: :create
  resources :tags, only: [:index, :show]
  resources :pages, only: [:new, :index, :create, :update]
  resources :users, only: [:show], path: '' do
    collection do
      get 'search'
    end
    resources :pages, path: '', only: [:show, :destroy, :edit] do
      get :download, on: :member
    end
  end
end
