Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  


  namespace :api do
    resources :partners, only: %i[index] do 
      collection do
        get 'day_times'
        get 'clear_cache'
      end
    end
    
  end
  root to: 'admin/dashboard#index'

  # root to: 'application#redirect_to_root', constraints: ->(request) { !request.env['PATH_INFO'].start_with?('/admin') }

  get '*path', to: 'admin/dashboard#index', constraints: ->(request) { !request.env['PATH_INFO'].start_with?('/admin') }

  get '/admin/*path', to: 'admin/dashboard#index'




end
