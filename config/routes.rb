Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  #API endpoints
  namespace :api do
    namespace :v1 do
      resources :experiences, only: [:index, :show]
      resources :users, only: [:show, :create] do
        resources :reservations, only: [:index, :create, :destroy]
      end
    end
  end
end
