Rails.application.routes.draw do
  # Static pages
  get 'newsletter', to: 'static_pages#newsletter'
  get 'privacy-policy', to: 'static_pages#privacy_policy'
  get 'loaderio-af1f76c262397ab753e3f2ef4dc64834', to: 'static_pages#loader_io_verification_staging'

  # Dynamic pages
  root 'categories#index'

  namespace :admin do
    resources :categories do
      put 'delete_icon', on: :member
    end
    resources :comments do
      put 'toggle_approval', on: :member
    end
    resources :external_resources
    resources :lists
    resources :list_items
    resources :resources
    resources :users

    root 'categories#index'
  end

  devise_for :users

  resource :search, only: [:show]
  resources :categories, only: [:index, :show], param: :slug do
    get 'page/:page', action: :show, on: :member
  end

  resources :resources, only: [:show], path: '', param: :slug do
    resources :comments, only: [:create]
  end
end