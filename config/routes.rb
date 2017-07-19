Rails.application.routes.draw do
  devise_for :drivers
  resources :dropoffs
  resources :pickups
  resources :clients

  namespace :api do
    namespace :v1 do
      get 'routes' => 'routes#index'
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
