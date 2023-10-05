# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  post '/callback', to: 'line_bot#callback'
  root 'home#top'

  # Static pages
  get '/privacy', to: 'home#privacy', as: 'home_privacy'
  get '/terms', to: 'home#terms', as: 'home_terms'
  get '/after_login', to: 'home#after_login'

  # Tag routes
  get 'photos/tag/:tag', to: 'photos#tag', as: 'photo_tag'
  get 'mypages/tag/:tag', to: 'mypages#tag', as: 'mypage_tag'

  # Public albums
  get 'public_albums', to: 'albums#public_index'

  # User routes
  resources :users, only: %i[new create edit update show] do
    delete :destroy, on: :collection, as: 'logout'
  end

  resources :notification_settings, only: %i[new create edit update]
  resources :mypages, only: %i[index]
  resources :photos, only: %i[new create show edit update destroy]
  resources :albums, only: %i[new create index edit update destroy show]

  resources :idols, only: %i[new create show edit update destroy] do
    resources :albums, only: [:show] do
      resources :photos
    end
  end
end
