Rails.application.routes.draw do
  resources :contact_schemas
  resources :contacts
  root to: 'visitors#index'
  devise_for :users
  resources :users
end
