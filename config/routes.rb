Rails.application.routes.draw do
  resources :sections, shallow: true do
    resources :topics do
      resources :posts, except: [:index, :new] do
        resources :complaints, only: :create
        resources :ratings, only: [:create, :update, :destroy]
      end

      resources :complaints, only: :create
    end
  end

  resources :complaints, only: [:index, :destroy]
  resources :users, shallow: true do
    resources :bans, except: :index
    resources :complaints, only: :index
  end

  resources :bans, only: :index
  resources :search, only: :index

  # Authentication
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root 'sections#index'
end
