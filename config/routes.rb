Rails.application.routes.draw do
  root "posts#index"
  get 'log_in', to: "sessions#new", as: "log_in"
  get 'log_out', to: "sessions#destroy", as: "log_out"
  get 'sign_up', to: "users#new", as: "sign_up"
  resources :sessions

  get 'discover', to: "posts#discover", as: "discover"
  resources :posts do
    resources :comments
    # comments belongs_to posts
  end

  resources :relationships, only: [:create, :destroy]
  # used for Follow and Unfollow

  get 'users/:id/following', to: "users#following", as: "following"
  get 'users/:id/followers', to: "users#followers", as: "followers"
  resources :users do
    member do
      get :following, :followers
      # allows following and followers method to be called from user
    end
  end
end
