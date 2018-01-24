Rails.application.routes.draw do

  root 'pages#index'
  get 'information/edit', to: 'information#edit'

  resources :services
  resources :photos
  resources :information, only: [:index, :update]
  resources :messages, only: [:index, :create, :destroy]

 end
