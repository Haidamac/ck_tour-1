Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      post '/auth/login', to: 'authentication#login'
      post 'password/forgot', to: 'password#forgot'
      post 'password/reset', to: 'password#reset'

      post 'admins/create_admin', to: 'admins#create_admin'

      resources :users do
        put '/change_role', to: 'users#change_role'
        resources :bookings
        resources :appointments
        resources :reservations
      end

      resources :attractions do
        resources :geolocations
        resources :comments
        resources :rates
      end

      resources :accommodations do
        resources :facilities
        resources :geolocations
        resources :rooms do
          resources :amenities
          resources :bookings
        end
        resources :comments
        resources :rates
      end

      resources :caterings do
        resources :geolocations
        get '/reservations', to: 'reservations#list_for_partner'
        resources :comments
        resources :rates
      end

      # resources :plans, except: :show
      # get 'plans/show', to: 'plans#show'
      get 'plans/show'
      resource :plan
      resource :billing

      resources :tours do
        resources :places do
          resources :geolocations
        end
        resources :appointments
        resources :comments
        resources :rates
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root 'authentication#login'
  root 'api/v1/attractions#index'
end
