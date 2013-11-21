Shpora::Application.routes.draw do

  root "home#index"
  get '/recent', to: 'pages#show', as: :recent_pages
  post ':user_id/favorites/:page_id', to: 'favorites#create', as: :new_favorite
  delete ':user_id/favorites/:page_id', to: 'favorites#destroy', as: :delete_favorite
  get ':user_id/favorites', to: 'favorites#index', as: :favorites
  #get '/tag/:tag_name', to: 'tags#show', as: :tag
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :tags, :only => [:index, :show]
  resources :pages, :only => [:new, :index, :create, :edit, :update]
  resources :users, :only => [:show], path: '' do
    collection do
      get 'search'
    end
    resources :pages, path: '', :only => [:show, :destroy]
  end
  

  #get ':username', to: 'users#show', as: :user
  #get ':username/:page_id', to: 'pages#show', as: :full_page
  
   
end
