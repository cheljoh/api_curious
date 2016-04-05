Rails.application.routes.draw do
  get "/auth/tumblr", as: "tumblr_login"
  get "/auth/tumblr/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, only: [:show, :index]
  #get "/dashboard", to: "users#show"

  root to:  "home#index"
end
