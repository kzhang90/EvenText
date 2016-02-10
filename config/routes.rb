Rails.application.routes.draw do

  root 'application#index'
  get  'home', to: 'application#home'
  get  'search_apis', to: 'application#search_apis'

  devise_for :users, :controllers => { :omniauth_callbacks => 'callbacks' }

  resources :users, only: [:index, :show] do
    resources :bookmarks, shallow: true, except: [:new]
    resources :reminders, shallow: true
  end

  resources :friendships

end

# index PAGE
# show PAGE
# edit PAGE
# new PAGE
# create ACTION
# update ACTION
# destroy ACTION




