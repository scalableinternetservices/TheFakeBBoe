Rails.application.routes.draw do
<<<<<<< HEAD
  resources :user_feeds
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :memes
=======
  root 'sessions#new'

  get 'sessions/new'

  resources :users

  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  # delete 'logout'  => 'sessions#destroy'
  get 'logout' => 'sessions#destroy'

  resources :conversations
  post '/conversations/:id/addUser', to: 'conversations#addUser', as: :conversation_add_user
  post '/conversations/:id/writeMessage', to: 'conversations#writeMessage', as: :conversation_write_message
  post '/conversations/:id/createUser', to: 'conversations#createUser' # Debug route remove later

  resources :memes

  resources :profiles
  post '/profiles/:id/addFriend', to: 'profiles#addFriend', as: :profile_add_friend
>>>>>>> db78c8d9f969ba3bc675b30b6317f36a853672d5
end
