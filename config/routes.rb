Rails.application.routes.draw do
  root 'categories#index'

  resources :categories, only: [:index, :show] do
    resources :items, only: [:new]
  end

  resources :items, only: [:show]
end