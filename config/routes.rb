Rails.application.routes.draw do
  devise_for :users, controllers: {
  registrations: "users/registrations",
  sessions: "users/sessions"
}

  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")

  get "vet/profile", to: "vets#profile", as: :vet_profile
  # get "vet/appointments", to: "vets#appointments", as: :vet_appointments

  # root "posts#index"

  # Profile (logged-in user)
  resource :user, only: [:show, :edit, :update]
  # vets
  resources :vets, only: [:index, :show] do
    resources :availabilities, only: [:index, :new, :create, :destroy]
  end
  # Pets
  resources :pets, only: [:new, :create, :index, :show, :edit, :update, :destroy]
  # Appointments
  resources :appointments, only: [:index, :new, :create, :show, :destroy]
end
