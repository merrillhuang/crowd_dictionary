Rails.application.routes.draw do
  root "languages#landing"
  
  resources :phrases
  resources :ratings
  resources :languages
  devise_for :users
  
  get "phrase_search", to: "phrases#search", as: :phrase_search
end
