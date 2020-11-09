Rails.application.routes.draw do
  devise_for :users
  
  #game controller routes
  get 'games/new/:user_id', to: 'games#new'
  post 'games/new', to: 'games#create' 
  get 'games/:game_id', to: 'games#show', as: 'game'
  get 'games/:game_id/edit', to: 'games#edit'
  post 'games/:game_id/edit', to: 'games#update'
  get 'library/:user_id', to: 'games#library', as: 'library'
  
  get 'profiles/:user_id', to: 'users#profile', as: 'profile'
  #root route
  root 'games#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
