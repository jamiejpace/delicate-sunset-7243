Rails.application.routes.draw do
  resources :flights, only: :index
  resources :tickets, only: :destroy
  resources :airlines, only: :show
end
