Rails.application.routes.draw do
  resources :conversations
  post '/conversations/:id/addUser', to: 'conversations#addUser', as: :conversation_add_user

  post '/conversations/:id/createUser', to: 'conversations#createUser' # Debug route remove later
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :memes
end
