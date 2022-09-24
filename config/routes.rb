Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show]
  resources :groups do
    resources :user_transactions
  end
  resources :home
  root "home#index"
end
