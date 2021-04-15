Rails.application.routes.draw do
  devise_for :admins

  # namespace :admin do
  #   resources :products
  #   resources :categories
  # end

  resources :products do
    member do
      delete 'remove_image_attachment'
    end
  end
  resources :categories
  root 'products#index'
  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :products do
    post 'csv_upload'
  end
end
