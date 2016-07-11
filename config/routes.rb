Rails.application.routes.draw do

  resources :charges, only: [:new, :create]

  resources :wikis

  resources :users, only: [:new, :create, :show]

  resources :sessions, only: [:new, :create, :destroy]

  get 'users/upgrade' => 'users#upgrade'

  post 'users/:id/' => 'users#downgrade'

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
