Rails.application.routes.draw do
  devise_for :users
  
  #game controller routes
  get 'games/:game_id', to: 'games#show'
  get 'games/:game_id/edit', to: 'games#edit'
  post 'games/:game_id/edit', to: 'games#update'
  get 'games/new', to: 'games#new'
  post 'games/new', to: 'games#create' 
  get 'profiles/:user_id', to: 'users#profile', as: 'profile'
  get 'library/:user_id', to: 'games#library', as: 'library'
 
  #root route
  root 'games#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
