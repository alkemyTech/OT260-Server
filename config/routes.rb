Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get ':id/public', to: 'organizations#public'
      resources :categories, only: [:update]
    end
  end
end
