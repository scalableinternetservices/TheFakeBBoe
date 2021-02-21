Rails.application.routes.draw do
  resources :user_feeds
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'home#index'

  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  resources :users

  resources :conversations
  post '/conversations/:id/addUser', to: 'conversations#addUser', as: :conversation_add_user
  post '/conversations/:id/writeMessage', to: 'conversations#writeMessage', as: :conversation_write_message
  post '/conversations/:id/createUser', to: 'conversations#createUser' # Debug route remove later

  resources :memes

  resources :profiles
  post '/profiles/:id/addFriend', to: 'profiles#addFriend', as: :profile_add_friend
end
