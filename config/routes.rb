Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'id/public', to: 'categories#public'
    end
  end
end
