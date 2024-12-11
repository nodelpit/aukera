Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"

  #profile user
  get "myprofile", to: "users#show", as: :myprofile
  get "myprofile/edit", to: "users#edit", as: :edit_myprofile
  patch "myprofile", to: "users#update"

  resources :movies, only: [:index, :show]

  resources :playlists do
    resources :movies do
      resources :movies_playlists, only: [:create]
    end
  end
  resources :movies_playlists, only: [:destroy]
end
