Rails.application.routes.draw do

  # authenticate :user, ->(user) { user.admin? } do
  #   require 'sidekiq/web'
  #   mount Sidekiq::Web => '/sidekiq'
  # end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
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
        get 'clear_cache'
        get 'day_times_logic'
        get 'zip_codes_logic'
        get 'countries_logic'
        get 'zip_code_shippings'
        get 'weekend_shippings'
        get 'shipping_threshold'
        get 'shipping_infos'
        get 'holidays'
        get 'shipping_custom_message'
        get 'active_partners'
        post 'order_webhooks'
      end
    end
    
  end
  root to: 'admin/orders#index'

  # root to: 'application#redirect_to_root', constraints: ->(request) { !request.env['PATH_INFO'].start_with?('/admin') }

  get '*path', to: 'admin/orders#index', constraints: ->(request) { !request.env['PATH_INFO'].start_with?('/admin') }

  get '/admin/*path', to: 'admin/orders#index'




end
