Rails.application.routes.draw do
  root 'static_pages#home'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  resources :users, except: [:index] do
    resources :subscriptions, only: [:index, :new, :create, :destroy]
    resources :feed_categorizations, only: [:index, :create, :destroy]
  end
  resources :feeds, only: [:create, :destroy] do
    resources :entries, only: [:index, :show]
  end
  resources :categories, only: [:create, :update, :destroy]
end
