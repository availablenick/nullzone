Rails.application.routes.draw do
  get 'main/index', as: :main
  
  resources :topicos do
    resources :respostas
  end

  resources :usuarios do
    resources :respostas
  end

  root to: 'main#index'
end
