Rails.application.routes.draw do

  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  get 'welcome/index'

  get 'about' => 'welcome#about'

  root 'welcome#index'

  resources :users, only: [:new, :create]

  post 'users/confirm' => 'users#confirm'

end
