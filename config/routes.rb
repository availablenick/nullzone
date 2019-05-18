Rails.application.routes.draw do
  get 'main/', to: 'main#index'
  
  resources :topicos do
    resources :posts
  end

  resources :usuarios do
    resources :topicos
  end

  root to: 'main#index'
end
