Rails.application.routes.draw do
  root 'categories#index'

  resources :categories, only: [:index, :show]
  resources :resources, only: [:show]
end