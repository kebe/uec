Rails.application.routes.draw do
 
  authenticated :driver do
    root :to => "routes#default_route"
  end
  #root declaration order is important
  devise_scope :driver do
    root to: "devise/sessions#new"
  end
  resources :contracts
  resources :operations
  devise_for :drivers
  resources :dropoffs
  resources :pickups
  resources :clients

  namespace :api do
    namespace :v1 do
      post 'create_operation' => 'operations#create_operation'
      get 'routes' => 'routes#index'
      get 'route/:id' => 'routes#show'
    end
  end
  resources :routes do
    member do
      get 'today_schedule'
    end 
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
