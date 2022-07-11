Rails.application.routes.draw do
  resources :people
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
    end
  end
end
