Rails.application.routes.draw do
  root "languages#index"
  
  resources :phrases
  resources :ratings
  resources :languages
  devise_for :users
  
end
