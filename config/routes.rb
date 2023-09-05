Rails.application.routes.draw do
  post '/callback', to: 'line_bot#callback'
  root to: 'home#after_login'
  get 'terms', to: 'home#terms'
  get '/after_login', to: 'home#after_login'
  get 'photos/tag/:tag', to: 'photos#tag', as: 'photo_tag'
  get 'mypages/tag/:tag', to: 'mypages#tag', as: 'mypage_tag'
  get 'public_albums', to: 'albums#public_index'
  resources :users, only: [:new, :create, :edit, :update, :show]
  delete '/logout', to: 'users#destroy', as: 'logout'
  resources :notification_settings, only: [:new, :create, :edit, :update]
  resources :mypages, only: %i[index]
  resources :photos, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :albums, only: [:new, :create, :index, :edit, :update, :destroy, :show]
  resources :idols, only: %i[new create show edit update destroy] do
    resources :albums, only: [:show] do
      resources :photos
    end
  end
end
