Rails.application.routes.draw do
  resources :user_feeds
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'home#index'

  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  get    'logout'  => 'sessions#destroy'

  resources :users

  resources :conversations
  post '/conversations/:id/addUser', to: 'conversations#addUser', as: :conversation_add_user
  post '/conversations/:id/writeMessage', to: 'conversations#writeMessage', as: :conversation_write_message 

  resources :memes

  resources :profiles
  post '/profiles/:id/addFriend', to: 'profiles#addFriend', as: :profile_add_friend

  get '/matches' => 'matches#index'
  post '/matches/likeProfile', to: 'matches#likeProfile', as: :matches_like_profile
  get '/matches/matchSuccess/:id', to: 'matches#matchSuccess', as: :match_success
  
end
