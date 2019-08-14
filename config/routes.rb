Rails.application.routes.draw do
  
  resources :users

  root 'users#index'

  get '/landing', to: "users#landing"

  get '/validate', to: "users#validate"

  post '/validate', to: "users#validate"

  get '/display', to: "users#display"

  post '/display', to: "users#display"

  get '/logout', to: "users#logout"

end
