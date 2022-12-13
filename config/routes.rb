# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#home'
  get 'about', to: 'pages#about'

  # Routes for User actions
  get 'signup', to: 'users#new'

  # Login actions - to be managed by the sessions controller
  #  1.  When (a signed up) user clicks logs in, initiate a new session
  get 'login', to: 'sessions#new'
  #
  # 2.  When the user submits theior login information, process the definition
  #     of a new session.  Recall the HTTP verb "post" denotes creation of a new
  #     Rails resource
  post 'login', to: 'sessions#create'

  # Chatroom routes
  get 'chatroom', to: 'chatroom#index'
end
