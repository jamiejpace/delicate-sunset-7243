Rails.application.routes.draw do
  resources :flights, only: :index
  resources :tickets, only: :destroy
end
