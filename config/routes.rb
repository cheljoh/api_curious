Rails.application.routes.draw do
  get "/auth/tumblr", as: "tumblr_login"
  get "/auth/tumblr/callback", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users, only: [:show, :index]

  root to:  "home#index"
  post "/", to: "home#update"
end
