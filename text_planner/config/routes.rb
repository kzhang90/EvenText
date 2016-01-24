Rails.application.routes.draw do

  root 'application#index'
  get  'home', to: 'application#home'
  get  'search_apis', to: 'application#search_apis'

  devise_for :users, :controllers => { :omniauth_callbacks => 'callbacks' }

  resources :users, only: [:index, :show] do
    resources :bookmarks, shallow: true, only: [:index, :edit, :create, :update, :destroy]
    # resources :comments, shallow: true, only: [:index, :update]
    # index of user's comments will be on user's profile, can they destroy?!
    resources :friendships, shallow: true, only: [:index, :create, :destroy]
    # research twilio and decide below:
    resources :reminders, shallow: true
  end

  # bookmarks will not have comments in MVP
  # resources :bookmarks, only: [] do
  #   resources :comments, shallow: true
  # end

end

# index PAGE
# show PAGE
# edit PAGE
# new PAGE
# create ACTION
# update ACTION
# destroy ACTION




