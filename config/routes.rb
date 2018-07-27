Rails.application.routes.draw do
  root 'categories#index'

  resources :categories, only: [:index, :show], param: :slug do
    resources :resource_recommendations, only: [:new, :create], path: '', path_names: { new: 'recommend-resource' }
  end

  resources :resources, only: [:show], path: '', param: :slug do
    resources :information_recommendations, only: [:new, :create], path: '', path_names: { new: 'add-information' }
    resources :comments, only: [:create]
  end
end