Shpora::Application.routes.draw do

  root 'home#index'

  get '/recent', to: 'pages#show', as: :recent_pages
  post ':user_id/favorites/:page_id', to: 'favorites#create', as: :new_favorite
  delete ':user_id/favorites/:page_id', to: 'favorites#destroy', as: :delete_favorite
  get ':user_id/favorites', to: 'favorites#index', as: :favorites

  devise_for :users

  namespace :assets do
    resources :tags, only: :index
  end

  resources :uploads, only: :create
  resources :tags, only: [:index, :show]
  resources :pages, only: [:new, :index, :create, :update]
  resources :users, only: [:show], path: '' do
    collection do
      get 'search'
    end
    resources :pages, path: '', only: [:show, :destroy, :edit]
  end


  get '/auth/:provider/callback', to: 'authentications#create'
  get '/auth/failure', to: redirect('/')

  resources :authentications, only: [:create, :destroy]
end
