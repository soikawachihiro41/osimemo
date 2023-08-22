Rails.application.routes.draw do
  root 'home#top'
  get 'terms', to: 'home#terms'
  get '/after_login', to: 'home#after_login'
  get 'photos/tag/:tag', to: 'photos#tag', as: 'photo_tag'
  get 'mypages/tag/:tag', to: 'mypages#tag', as: 'mypage_tag'
  resources :sessions, only: [:new, :create]
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  resources :mypages, only: %i[index]
  resources :photos, only: [:new, :create, :show, :edit, :update, :destroy]
  resources :albums, only: [:new, :create, :index]
  resources :idols, only: %i[new create show] do
    resources :albums, only: [] do
      resources :photos
    end
  end
end
