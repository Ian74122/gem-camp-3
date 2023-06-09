Rails.application.routes.draw do
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  constraints(ClientDomainConstraint.new) do
    root 'posts#index'

    resources :posts do
      resources :comments, except: :show
    end
    resources :categories
    resources :orders do
      post :revoke
    end
    namespace :api do
      namespace :v1 do
        resources :regions, only: %i[index show], defaults: { format: :json } do
          resources :provinces, only: :index, defaults: { format: :json }
        end
        resources :provinces, only: %i[index show], defaults: { format: :json } do
          resources :cities, only: :index, defaults: { format: :json }
        end
        resources :cities, only: %i[index show], defaults: { format: :json } do
          resources :barangays, only: :index, defaults: { format: :json }
        end
        resources :barangays, only: %i[index show], defaults: { format: :json }
      end
    end
  end

  constraints(AdminDomainConstraint.new) do
    namespace :admin do
      root 'users#index'
      resources :users, only: :index
      resources :orders do
        post :revoke
        post :submit
        post :pay
      end
    end
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end
end
