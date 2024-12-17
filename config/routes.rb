Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "myprofile", to: "users#show", as: :myprofile
  get "myprofile/edit", to: "users#edit", as: :edit_myprofile
  patch "myprofile", to: "users#update"
  patch "myprofile/photo", to: "users#update_photo", as: :update_photo_myprofile


  resources :users, only: [:new, :create] do
    member do
      patch :update_photo
      patch :update_username
      delete :remove_genre
      delete :remove_platform
      delete :remove_playlist
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest


  # Defines the root path route ("/")
  # root "posts#index"

  resources :movies, only: [:index, :show] do
    get "/new_movie_to_playlist", to: "movie_playlists#new", as: :new_movie_to_playlist
    delete "/remove_movie_from_playlist", to: "movie_playlists#destroy", as: :remove_movie_from_playlist
  end

  resources :playlists do
    resources :movies do
      delete "/remove_movie_from_playlist", to: "movie_playlists#destroy", as: :remove_movie_from_playlist
    end
  end

  resources :playlists

  resources :movie_playlists, only: [:create, :destroy]
end
