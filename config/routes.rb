Rails.application.routes.draw do
  namespace :admin do
    resources :categories do
      put 'delete_icon', on: :member
    end
    resources :comments do
      put 'toggle_approval', on: :member
    end
    resources :external_resources
    resources :information_recommendations
    resources :lists
    resources :list_items
    resources :resources
    resources :resource_recommendations
    resources :users

    root 'categories#index'
  end

  root 'categories#index'

  devise_for :users

  get 'newsletter', to: 'static_pages#newsletter'
  get 'loaderio-af1f76c262397ab753e3f2ef4dc64834', to: 'static_pages#loader_io_verification_staging'

  resource :search, only: [:show]
  resources :categories, only: [:index, :show], param: :slug do
    get 'page/:page', action: :show, on: :member
    resources :resource_recommendations, only: [:new, :create], path: '', path_names: { new: 'recommend-resource' }
  end

  resources :resources, only: [:show], path: '', param: :slug do
    resources :information_recommendations, only: [:new, :create], path: '', path_names: { new: 'add-information' }
    resources :comments, only: [:create]
  end
end