Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post 'auth/login', to: 'users#login'
      get 'auth/me', to: 'users#me'
      post 'auth/register', to: 'users#create'
      
      resources :categories, only: %i[index create show]
      resources :organizations, only: [] do
        get 'public', on: :member
      end
    end
  end
  
end
