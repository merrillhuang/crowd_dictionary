Rails.application.routes.draw do
  root "languages#landing"
  
  resources :phrases
  resources :ratings
  resources :languages
  devise_for :users
  
end
