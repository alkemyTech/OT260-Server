Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'organization/:id/public', to: 'organizations#public'
      resources :organizations, only: [:create, :update] 
      resources :categories, only: [:update]
    end
  end
end
