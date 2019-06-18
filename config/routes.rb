Rails.application.routes.draw do
  get 'main/', to: 'main#index'
  
  get '/logar', to: 'usuario_sessions#new'
  post '/logar', to: 'usuario_sessions#create'
  delete '/deslogar', to: 'usuario_sessions#destroy'

  get '/denuncias', to: 'denunciations#index'
  resources :topicos, except: :create do
    resources :posts, except: :create do
      post '/denuncias', to: 'denunciations#create'
      delete '/denuncias/:id', to: 'denunciations#destroy', as: :denuncia
    end

    post '/', to: 'posts#create', as: :new_post
  end

  get '/search', to: 'topicos#search', as: :topicos_search
  post '/topicos/new', to: 'topicos#create'

  post '/usuarios/new', to: 'usuarios#create'
  resources :usuarios, except: :create

  root to: 'main#index'
end
