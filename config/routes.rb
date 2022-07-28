Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api/v1/docs'
  mount Rswag::Api::Engine => '/api/v1/docs'
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
      
      resources :categories, only: %i[index create show update destroy]
      resources :members, only: [:index]
      resources :news, only: %i[show create update destroy]
      resources :organizations, only: [] do
        get 'public', on: :member
      end
<<<<<<< HEAD
>>>>>>> a2f41c10f3c85cb832fb9d1f5e41659b0a0fec9c
=======
      resources :users, only: %i[index update]
>>>>>>> 62d4f948f42925bc1b73d6fb6cc4a951b2aad339
    end
  end
  
end
