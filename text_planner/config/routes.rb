Rails.application.routes.draw do

  root 'welcome#index'

  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :users do
    resources :bookmarks, shallow: true
    resources :friendships, shallow: true
    resources :comments, shallow: true
  end

  resources :bookmarks do
    resources :comments, shallow: true
  end

  resources :reminders

end
