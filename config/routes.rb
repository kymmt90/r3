Rails.application.routes.draw do
  root 'static_pages#home'

  get  'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :categories, except: [:index, :show]

  resources :feeds, only: [:show, :create, :destroy] do
    resources :entries, only: [:show]
  end
  patch 'feeds/refresh/:id' => 'feeds#refresh', as: 'refresh_feed'

  resources :reading_statuses, only: [:update]

  resources :users, except: [:index] do
    resources :feed_categorizations, except: [:edit, :update], path: 'categorizations'
    resources :subscriptions, except: [:edit, :update]
  end

  match '*path' => 'application#error404', via: :all
end
