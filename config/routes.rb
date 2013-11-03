Shpora::Application.routes.draw do
  root "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :pages, :only => [:new, :index, :create, :update]
  resources :users, :only => [:show], path: '' do
    resources :pages, path: '', :only => [:show]
  end
  

  #get ':username', to: 'users#show', as: :user
  #get ':username/:page_id', to: 'pages#show', as: :full_page
  #get '/new', to: 'pages#new', as: :new_page
   
end
