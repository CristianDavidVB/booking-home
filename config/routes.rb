Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check
  root "properties#index"
  resources :properties, only: %i[ index show ]
  resources :user_properties
end