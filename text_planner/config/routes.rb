Rails.application.routes.draw do

  root 'welcome#index'
  get 'home', :to => 'home#index'
  get 'searchApis', :to => 'home#searchApis'

  devise_for :users, :controllers => { registrations: 'registrations' }
  
  resources :users, shallow: true do
    resources :bookmarks, except: :new
    resources :friendships, only: [:index, :show, :destroy]
    resources :reminders
  end

  resources :bookmarks, except: :new, shallow: true do
    resources :comments
  end



end
