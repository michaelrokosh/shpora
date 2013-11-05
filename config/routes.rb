Shpora::Application.routes.draw do
  root "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :pages, :only => [:new, :index, :create, :edit]
  resources :users, :only => [:show], path: '' do
    resources :pages, path: '', :only => [:show, :destroy]
  end
  
  #get ':username', to: 'users#show', as: :user
  #get ':username/:page_id', to: 'pages#show', as: :full_page
  #get '/new', to: 'pages#new', as: :new_page
   
end
