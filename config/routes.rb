Rails.application.routes.draw do
  get 'main/', to: 'main#index'
  
  resources :usuario_sessions, only: [:new, :create]

  get '/logar', to: 'usuario_sessions#new', as: :logar
  delete '/deslogar', to: 'usuario_sessions#destroy', as: :deslogar

  get '/search', to: 'topicos#search', as: :topicos_search
  resources :topicos do
    resources :posts
  end

  resources :usuarios do
    resources :topicos
  end

  root to: 'main#index'
end
