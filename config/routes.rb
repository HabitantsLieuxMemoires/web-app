Hlm::Application.routes.draw do
  root "home#index"

  get "logout", to: "sessions#destroy",  as: "logout"
  get "login",  to: "sessions#new",      as: "login"
  get "signup", to: "users#new",         as: "signup"

  resources :users,           only: [:new, :create]
  resources :sessions,        only: [:new, :create]
  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :articles do
    resources :comments, only: [:index, :new, :create]
    resources :images,   only: [:index, :new, :create]
  end

  resources :themes, only: [:show]

end
