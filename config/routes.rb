Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api/v1/docs'
  mount Rswag::Api::Engine => '/api/v1/docs'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'auth/login', to: 'users#login'
      get 'auth/me', to: 'users#me'
      post 'auth/register', to: 'users#create'
      
      resources :categories, only: %i[index create show update destroy]
      resources :members, only: %i[index create]
      resources :news, only: %i[show create update destroy]
      resources :organizations, only: [] do
        get 'public', on: :member
      end
      resources :slides, only: :create
      resources :users, only: %i[index update]
    end
  end
  
end
