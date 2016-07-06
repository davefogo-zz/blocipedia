Rails.application.routes.draw do
  get 'welcome/index'

  get 'about' => 'welcome#about'

  root 'welcome#index'

  resources :users, only: [:new, :create]

end
