Rails.application.routes.draw do
  get 'main/', to: 'main#index'
  
  get '/logar', to: 'usuario_sessions#new'
  post '/logar', to: 'usuario_sessions#create'
  delete '/deslogar', to: 'usuario_sessions#destroy'

  get '/search', to: 'topicos#search', as: :topicos_search
  resources :topicos do
    resources :posts
  end

  post '/usuarios/new', to: 'usuarios#create'
  resources :usuarios, except: [:create]

  root to: 'main#index'
end
