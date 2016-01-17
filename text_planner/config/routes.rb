Rails.application.routes.draw do

  root 'welcome#index'

  devise_for :users, :controllers => { registrations: 'registrations' }

  get 'home', :to => 'home#index'
  get 'searchApis', :to => 'home#searchApis'
  
  resources :users do
    resources :bookmarks, shallow: true
    resources :friendships, only: [:index, :show, :destroy], shallow: true
  end

  resources :bookmarks do
    resources :comments, shallow: true
  end

  resources :reminders

end
