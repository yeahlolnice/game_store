Rails.application.routes.draw do
  devise_for :users

  #pages routes
  get 'profiles/:user_id', to: 'pages#profile', as: 'profile'
  get 'library/:user_id', to: 'pages#library', as: 'library'
 
  #root route
  root 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
