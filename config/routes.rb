Rails.application.routes.draw do
  get 'main/', as: :main, to: 'main#index'
  
  resources :topicos do
    resources :posts
  end

  resources :usuarios do
    resources :posts
  end

  root to: 'main#index'
end
