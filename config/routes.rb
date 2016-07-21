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

  # namespace :wechat do
  #   resources :records
  # end

  resource :wechat, only: [:show, :create]


  get 'vue_learn' => 'home#vue_learn'
  get 'position' => 'home#position'

  namespace :v1 do
    post '/login', to: 'sessions#create'

    resources :topics, only: [:index]
  end

end
