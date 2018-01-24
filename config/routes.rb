Rails.application.routes.draw do

  root 'pages#index'
  get 'information/edit', to: 'information#edit'

  resources :services
  resources :information, only: [:index, :update]

 end
