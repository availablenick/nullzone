Rails.application.routes.draw do
  get 'complaints/index'
  get 'posts/index'
  get 'posts/show'
  get 'posts/new'
  get 'posts/edit'
  get 'topics/index'
  get 'topics/show'
  get 'topics/new'
  get 'topics/edit'
  get 'threads/index'
  get 'threads/show'
  get 'threads/edit'
  get 'threads/new'
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  get 'users/new'
  
  get 'sections/index'
  get 'sections/show'
  get 'sections/edit'
  get 'sections/new'

  root 'sections#index'
end
