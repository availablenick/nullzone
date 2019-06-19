Rails.application.routes.draw do
  # Início
  get 'main/', to: 'main#index'
  root to: 'main#index'

  # Autenticação
  get '/logar', to: 'usuario_sessions#new'
  post '/logar', to: 'usuario_sessions#create'
  delete '/deslogar', to: 'usuario_sessions#destroy'

  # Denúncias
  get '/denuncias', to: 'denunciations#index'
  post '/denuncias', to: 'denunciations#create'
  delete '/denuncia/:id', to: 'denunciations#destroy', as: :denuncia

  # Tópicos
  post '/topicos/new', to: 'topicos#create'
  resources :topicos, except: :create do
    post '/', to: 'posts#create', as: :new_post
    resources :posts, except: :create
  end
  get '/search', to: 'topicos#search', as: :topicos_search

  # Usuários
  post '/usuarios/new', to: 'usuarios#create'
  resources :usuarios, except: :create
end
