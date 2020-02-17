Rails.application.routes.draw do
  resources :sections, shallow: true do
    resources :topics do
      resources :posts, except: [:index, :show, :new] do
        resources :ratings, only: [:create, :update, :destroy]
      end
    end
  end

  resources :complaints, only: [:index, :destroy]
  resources :users, shallow: true do
    resources :complaints, only: :index
  end

  root 'sections#index'
end
