Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      put 'status_update/create'
    end
  end

  root to: 'status_updates#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
