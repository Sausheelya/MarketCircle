Rails.application.routes.draw do
  resources :people, controller: 'peoples', as: 'people', path: 'people' do
    member do
      delete 'custom_destroy'
    end
  end
end
