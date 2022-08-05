# frozen_string_literal: true

Rails.application.routes.draw do
  
  root 'products#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: [:create]
  resources :products do
    collection do
      get :autocomplete
    end
    resources :comments
    resources :carts do
      member do
        post 'remove_from_cart'
      end
      resources :orders do
        resources :checkout, only: [:create]
        member do
          post 'find_cupon'
        end
      end
    end
  end
end
