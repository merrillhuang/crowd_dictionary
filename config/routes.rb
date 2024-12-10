Rails.application.routes.draw do
  root "languages#landing"
  
  devise_for :users, controllers: {
    omniauth_callbacks: "omniauth_callbacks",
  }

  resources :phrases, only: [:show, :create, :search]
  resources :ratings, only: [:create]
  resources :languages, except: [:edit, :update, :destroy]

  get "search", to: "languages#search", as: :language_search
  get "phrase_search", to: "phrases#search", as: :phrase_search
  get "users/:id", to: "users#show", as: :user
end
