Rails.application.routes.draw do

  root to: 'home#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'
  resources :users

  resources :topics do
    resources :replies
  end


end
