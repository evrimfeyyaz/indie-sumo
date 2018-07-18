Rails.application.routes.draw do
  root 'categories#index'

  resources :categories, only: [:index, :show]
  resources :resources, only: [:show]
  resources :resource_recommendations, only: [:new, :create]
end