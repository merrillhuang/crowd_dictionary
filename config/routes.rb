Rails.application.routes.draw do
  root "languages#landing"
  
  resources :phrases, only: [ :show, :create, :search ]
  resources :ratings, only: [ :create ]
  resources :languages, except: [ :edit, :update, :destroy ]
  devise_for :users
  
  get "phrase_search", to: "phrases#search", as: :phrase_search
  get "users/:id", to: "users#show", as: :user
end
