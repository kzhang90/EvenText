Rails.application.routes.draw do

  # root 'welcome#index'
  root 'application#index'
  get 'home', to: 'application#home'
  get 'search_apis', to: 'application#search_apis'

  devise_for :users, :controllers => { :omniauth_callbacks => 'callbacks' }
  
  resources :users, only: [] do
    resources :bookmarks, shallow: true, except: [:new, :edit, :update]
    resources :comments, :friendships, :reminders, shallow: true, only: [:index, :show]
    # resources :bookmarks, except: :new
    # resources :friendships, only: [:index, :show, :destroy]
    # resources :reminders
  end

  resources :bookmarks, except: :index do
    resources :comments
  end

end
