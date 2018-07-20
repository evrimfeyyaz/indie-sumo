Rails.application.routes.draw do
  root 'categories#index'

  resources :categories, only: [:index, :show] do
    resources :resource_recommendations, only: [:new, :create]
  end

  resources :resources, only: [:show] do
    resources :information_recommendations, only: [:new, :create]
  end
end