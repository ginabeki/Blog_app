Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
    resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create, :destroy]
    end
  end

# API endpoints
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :update, :destroy, :show] do
        resources :posts, only: [:index, :create, :update, :destroy, :show] do
          resources :comments, only: [:index, :show]
          resources :likes, only: [:index, :show]
        end
      end
    end
  end
end
