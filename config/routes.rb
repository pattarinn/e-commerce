Rails.application.routes.draw do
  devise_for :admins

  scope :admin do
    resources :products do
      member do
            delete 'remove_image_attachment'
      end
    end
    resources :categories
    resources :orders
  end

  # resources :products do
  #   member do
  #     delete 'remove_image_attachment'
  #   end
  # end
  # resources :categories
  root 'products#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :products do
    post 'csv_upload'
  end
end
