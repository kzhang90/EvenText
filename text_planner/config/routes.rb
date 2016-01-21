Rails.application.routes.draw do

  root 'application#index'
  get  'home', to: 'application#home'
  get  'search_apis', to: 'application#search_apis'

  devise_for :users, :controllers => { :omniauth_callbacks => 'callbacks' }
  
  # clean up routes...
  resources :users, only: [] do
    resources :bookmarks, shallow: true, except: [:new, :edit]
    resources :comments, shallow: true, only: [:index, :show]
    resources :friendships, shallow: true, only: [:index, :create, :destroy]
    resources :reminders, shallow: true
  end

  resources :bookmarks, only: [] do
    resources :comments, shallow: true
  end

end
