Rails.application.routes.draw do

  get 'users/upgrade' => 'users#upgrade'

  post 'users/:id/' => 'users#downgrade'

  resources :charges, only: [:new, :create]

  resources :wikis

  resources :users, only: [:new, :create, :show]

  resources :sessions, only: [:new, :create, :destroy]

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
