Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post "auth/register", to: "users#create"
    end
  end
end
