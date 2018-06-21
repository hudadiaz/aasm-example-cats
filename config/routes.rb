Rails.application.routes.draw do
  resources :cats
  root 'cats#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
