Rails.application.routes.draw do
  resources :profiles
  post '/profiles/:id/addFriend', to: 'profiles#addFriend', as: :profile_add_friend
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
