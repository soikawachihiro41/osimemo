Rails.application.routes.draw do
  root 'home#top'
  get 'terms', to: 'home#terms'
  get '/after_login', to: 'home#after_login'
  resource :user, only: %i[new create]
  resources :mypages, only: %i[index]
  resources :albums
  resources :idols, only: %i[new create]
end
