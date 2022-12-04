# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#home'

  # Login actions - to be managed by the sessions controller
  #  1.  Inital user creation
  get 'signup', to: 'sessions#new'
  #
  # 2.  Create a session based on successful login.
  #     Recall the HTTP verb "post" denotes creation of a new resource
  post 'login', to: 'sessions#create'
end
