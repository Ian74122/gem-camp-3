Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'posts#index'
  resources :posts do
    resources :comments, except: :show
  end
  resources :categories
end
