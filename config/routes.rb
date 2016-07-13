Rails.application.routes.draw do

  get 'users/upgrade' => 'users#upgrade'

  post 'users/:id/' => 'users#downgrade'

  resources :collaborators, only: [:create, :destroy]

  resources :charges, only: [:new, :create]

  resources :wikis

  resources :users, only: [:show, :new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
