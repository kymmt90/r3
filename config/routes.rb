Rails.application.routes.draw do
  root 'static_pages#home'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :users, except: [:index] do
    resources :subscriptions, only: [:index, :new, :create, :destroy]
    resources :feed_categorizations, only: [:index, :new, :create, :destroy]
  end
  resources :feeds, only: [:show, :create, :destroy] do
    resources :entries, only: [:show]
  end
  get 'feeds/refresh/:id' => 'feeds#refresh', as: 'refresh_feed'
  resources :categories, only: [:new, :create, :edit, :update, :destroy]
  resources :reading_statuses, only: [:update]
end
