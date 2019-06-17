Rails.application.routes.draw do
  get 'main/', to: 'main#index'
  
  get '/logar', to: 'usuario_sessions#new'
  post '/logar', to: 'usuario_sessions#create'
  delete '/deslogar', to: 'usuario_sessions#destroy'

  get '/search', to: 'topicos#search', as: :topicos_search
  post '/topicos/new', to: 'topicos#create'
  resources :topicos, except: :create do
    post '/', to: 'posts#create', as: :new_post
    resources :posts, except: :create
  end

  post '/usuarios/new', to: 'usuarios#create'
  resources :usuarios, except: :create

  root to: 'main#index'
end
