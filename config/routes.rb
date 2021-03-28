Rails.application.routes.draw do
  devise_for :admins
  resources :products
  root 'products#index'
  get 'home/index'
  resources :categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :products do
    post 'csv_upload'
  end
end
