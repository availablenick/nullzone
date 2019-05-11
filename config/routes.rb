Rails.application.routes.draw do
  get 'main/index', as: :main
  
  resources :usuarios do
    resources :respostas

    resources :topicos do
      resources :respostas
    end
  end

  root to: 'main#index'
end
