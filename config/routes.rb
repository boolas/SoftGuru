SoftGuru::Application.routes.draw do
  get 'signin', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'issues', to: 'issues#all', as: 'issues'

  resources :projects do
    resources :issues
  end

  resources :users
  resources :sessions

  root 'projects#index'
end
