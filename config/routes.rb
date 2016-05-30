Rails.application.routes.draw do
  root 'static_pages#home'
  resources :users, except: [:index]
  resources :feeds, only: [:create, :destroy]
  resources :categories, only: [:create, :update, :destroy]
end
