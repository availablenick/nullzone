Rails.application.routes.draw do
	get 'main/index', as: :main
  
  resources :topicos
  resources :usuarios

  root to: 'main#index'
end
