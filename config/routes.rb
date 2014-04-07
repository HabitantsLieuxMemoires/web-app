Hlm::Application.routes.draw do
  get "articles/show"
  get "articles/new"
  get "article/new"
  root "home#index"

  get "logout"  => "sessions#destroy",  :as => "logout"
  get "login"   => "sessions#new",      :as => "login"
  get "signup"  => "users#new",         :as => "signup"

  resources :users
  resources :sessions
  resources :password_resets

  resources :articles
end
