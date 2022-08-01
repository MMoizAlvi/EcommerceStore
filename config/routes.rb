Rails.application.routes.draw do

  # root 'pages#home'
  root 'products#index'
  devise_for :users
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
