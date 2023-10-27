Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # API endpoints
  namespace :api do
    resources :users, param: :username, only: [:show, :create]
  end
end
