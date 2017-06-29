Rails.application.routes.draw do
  resources :dropoffs
  resources :pickups
  resources :clients
  resources :routes do
    member do
      get 'today_schedule'
    end 
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
