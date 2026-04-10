Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :person
      namespace :user do
        post "sign_in", to: "sessions#sign_in"
        post "sign_out", to: "sessions#sign_out"
        get "me", to: "sessions#me"
      end
    end
  end
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  mount ActionCable.server => "/cable"

  # Defines the root path route ("/")
  # root "posts#index"
end
