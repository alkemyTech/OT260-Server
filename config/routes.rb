Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post "auth/login", to: "authentication#login"
      post "auth/register", to: "users#create"
      resources :slides, only: [:create]
    end
  end
end
