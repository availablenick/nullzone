Rails.application.routes.draw do
  get 'main/index', as: :main
  
  resources :topicos do
    resources :posts
  end

  resources :usuarios do
    resources :posts
  end

  root to: 'main#index'
end
