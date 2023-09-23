Rails.application.routes.draw do
  post '/callback', to: 'line_bot#callback'
  root to: 'home#top'
  get '/privacy', to: 'home#privacy', as: 'home_privacy'
  get '/terms', to: 'home#terms', as: 'home_terms'
  # resources :homes, only: [:top, :before_login, :after_login, :terms]
  get '/after_login', to: 'home#after_login'
  get 'photos/tag/:tag', to: 'photos#tag', as: 'photo_tag'
  get 'mypages/tag/:tag', to: 'mypages#tag', as: 'mypage_tag'
  get 'public_albums', to: 'albums#public_index'
  resources :users, only: %i[new create edit update show]
  delete '/logout', to: 'users#destroy', as: 'logout'
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
