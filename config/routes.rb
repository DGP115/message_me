# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#home'
  get 'about', to: 'pages#about'

  # Routes for User actions
  get 'signup', to: 'users#new'
  # resources :users, only: %i[show index create edit update destroy]
  resources :users, only: %i[create]

  # Login actions - to be managed by the sessions controller
  # 1.  When (a signed up) user clicks log in, initiate a new session
  get 'login', to: 'sessions#new'
  #
  # 2.  When the user submits their login information, process the definition
  #     of a new session.  Recall the HTTP verb "post" denotes creation of a new
  #     Rails resource (generally in response to a form submittal)
  post 'login', to: 'sessions#create'

  # 3. Logout and thus delete a user session
  delete 'logout', to: 'sessions#destroy'

  # Chatroom routes
  get 'chatroom', to: 'chatroom#index'
end
