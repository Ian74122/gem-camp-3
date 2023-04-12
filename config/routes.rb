Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'posts#index'

  resources :posts do
    resources :comments, except: :show
  end
  resources :categories

  namespace :api do
    namespace :v1 do
      resources :regions, only: %i[index show], defaults: { format: :json }
    end
  end
end
