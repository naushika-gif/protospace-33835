Rails.application.routes.draw do
  devise_for :users
  get 'prototypes/index'
  post 'prototypes/new'

  root to: "prototypes#index"
  resources :prototypes do
  resources :comments, only: :create
  end
  resources :prototypes
  resources :users, only: :show
end