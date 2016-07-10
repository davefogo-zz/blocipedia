Rails.application.routes.draw do

  resources :charges, only: [:new, :create]

  resources :wikis

  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  post 'users/confirm' => 'users#confirm'

  post 'users/premium' => 'users#premium'

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
