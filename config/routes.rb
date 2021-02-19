Rails.application.routes.draw do
  root 'sessions#new'

  get 'sessions/new'

  resources :users

  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  #delete 'logout'  => 'sessions#destroy'
  get 'logout'  => 'sessions#destroy'
end
