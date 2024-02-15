Rails.application.routes.draw do
  resources :peoples, only: [:index, :show, :create]
end