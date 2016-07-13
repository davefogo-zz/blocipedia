Rails.application.routes.draw do

  get 'users/upgrade' => 'users#upgrade'

  post 'users/:id/' => 'users#downgrade'

  resources :charges, only: [:new, :create]

  resources :wikis do
    resources :collaborators, only: [:create, :destroy]
  end

  resources :users, only: [:show, :new, :create]

  resources :sessions, only: [:new, :create, :destroy]

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
