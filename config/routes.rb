Rails.application.routes.draw do
  root 'home#top'
  get 'terms', to: 'home#terms'
  get '/after_login', to: 'home#after_login'
  resources :sessions, only: [:new, :create]
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  resources :mypages, only: %i[index]
  resources :photos
  resources :idols, only: %i[new create show] do
    resources :albums, only: %i[new create index] do
      resources :photos, only: [:index]
    end
  end
end
