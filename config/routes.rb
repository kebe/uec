Rails.application.routes.draw do
 
  authenticated :driver do
    root :to => "routes#default_route"
  end
  #root declaration order is important
  devise_for :drivers
  resources :contracts
  resources :operations
  resources :clients
  get 'app' => 'routes#app'
  namespace :api do
    namespace :v1 do
      devise_scope :driver do
        post "/drivers/create" => "sessions#create"
        post "/drivers/destroy" => "sessions#destroy"
      end
      post 'create_operation' => 'operations#create_operation'
      post 'remove_operation/:id' => 'operations#remove_operation'
      get 'todays_operations' => 'operations#todays_operations'
      get 'routes' => 'routes#index'
      get 'route/:id' => 'routes#show'
      get 'service-tickets/me' => 'service_tickets#me'
      post 'update-service-ticket/:id' => 'service_tickets#update_service_ticket'
      get 'drivers/me' => 'drivers#me'
      
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
