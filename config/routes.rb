Shpora::Application.routes.draw do

  root 'home#index'

  get '/recent', to: 'pages#show', as: :recent_pages
  post ':user_id/favorites/:page_id', to: 'favorites#create', as: :new_favorite
  delete ':user_id/favorites/:page_id', to: 'favorites#destroy', as: :delete_favorite
  get ':user_id/favorites', to: 'favorites#index', as: :favorites
  get '/robots.txt', to: 'robots#robots'

  devise_for :users, controllers: { omniauth_callbacks: 'callbacks' }

  concern :searchable do
    get :search, action: :index, on: :collection
  end

  namespace :assets do
    resources :tags, only: :index
  end

  namespace :admin do
    resources :pages, except: [:new, :create], concerns: [:searchable]
    resources :users, only: [:index, :show, :destroy], concerns: [:searchable] do
      get :relogin, action: :relogin, on: :member
      get :earn_money_news, action: :earn_money_news, on: :member
      collection do
        get :news
      end
      member do
        get :relogin, :earn_money_news
      end
    end
  end

  resources :earns, only: :index
  resources :uploads, only: :create
  resources :tags, only: [:index, :show]
  resources :pages, only: [:new, :index, :create, :update], concerns: [:searchable]
  resources :users, only: [:show], path: '' do
    collection do
      get 'search'
    end
    resources :pages, path: '', only: [:show, :destroy, :edit]
  end
end
