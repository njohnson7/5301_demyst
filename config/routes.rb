# /config/routes.rb

Rails.application.routes.draw do
  root to: 'posts#index'

  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  resources :comments, only: :index
end
