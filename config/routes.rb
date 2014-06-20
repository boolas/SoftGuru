SoftGuru::Application.routes.draw do
  resources :projects

  resources :users

  root 'projects#index'
end
