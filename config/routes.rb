Rails.application.routes.draw do
  resources :user_feed_subscriptions
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :memes
end
