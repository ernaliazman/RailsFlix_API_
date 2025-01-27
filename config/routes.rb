Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/swagger'
  mount Rswag::Api::Engine => '/swagger'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      resources :movies, only: [:show, :destroy, :create, :update] #specify certain endpoints to have custom

      resources :user, only: [] do
        collection do
          post :login, to: "user_authentication#login"
          post :signup, to: "user_authentication#signup"
        end
      end
    end
  end
end
