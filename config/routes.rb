Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
<<<<<<< HEAD
      post "auth/login", to: "authentication#login"
      post "auth/register", to: "users#create"
      resources :slides, only: [:create]
=======
      post 'auth/login', to: 'users#login'
      get 'auth/me', to: 'users#me'
      post 'auth/register', to: 'users#create'
      
      resources :categories, only: %i[create]
      resources :organizations, only: [] do
        get 'public', on: :member
      end
>>>>>>> a2f41c10f3c85cb832fb9d1f5e41659b0a0fec9c
    end
  end
  
end
