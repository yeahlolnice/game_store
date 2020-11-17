Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  #reviews controller routes
  resources :reviews
  post 'games/:id', to: 'reviews#create'
  post 'reviews/:id', to: 'reviews#update'
  # get 'games/:game_id/reviews/:review_id', to: 'reviews#show'
  # get 'games/:game_id/reviews/new', to: 'reviews#new'
  # get 'reviews/review_id/edit'
  
  #game controller routes
  get 'games/restricted', to: 'games#restricted'
  put "games/:id", to: "games#approved", as: "approve_game"
  resources :games
  get 'library/:user_id', to: 'games#library', as: 'library'
  post "games/:id/buy", to: 'games#buy', as: 'buy'
  get  'games/:id/success', to: 'games#success', as: 'success'
  get  'game/:id/cancel', to: 'games#cancel', as: 'cancel'
  # get 'games/new', to: 'games#new', as: 'games_new'
  # post 'games', to: 'games#create' 
  # get 'games/:game_id', to: 'games#show', as: 'game'
  # get 'games/:game_id/edit', to: 'games#edit', as: 'game_edit'
  # post 'games/:game_id/edit', to: 'games#update'
  
  #user routes
  get 'profiles/:user_id', to: 'users#show', as: 'profile'
  #root route
  root 'games#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
