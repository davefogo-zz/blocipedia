Rails.application.routes.draw do

  resources :charges, only: [:new, :create]

  resources :wikis

  resources :users, only: [:new, :create, :show]

  resources :sessions, only: [:new, :create, :destroy]

  get 'users/upgrade' => 'users#upgrade'

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
