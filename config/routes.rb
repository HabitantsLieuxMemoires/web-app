Hlm::Application.routes.draw do
  root "home#index"

  get "logout", to: "sessions#destroy",  as: "logout"
  get "login",  to: "sessions#new",      as: "login"
  get "signup", to: "users#new",         as: "signup"

  resources :users,           only: [:new, :create]
  resources :sessions,        only: [:new, :create]
  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :articles do
    get :autocomplete, on: :collection

    resources :reports,  only: [:new, :create]
    resources :videos,   only: [:index, :new, :create]

    resources :comments, only: [:index, :new, :create] do
      get   'page/:page',   action: :index, on: :collection
    end

    resources :images,   only: [:index, :new, :create] do
      get 'select', on: :collection
    end
  end

  resources :themes, only: [:show] do
    get 'page/:page', action: :show, on: :member
  end

  resources :chronologies, only: [:show] do
    get 'page/:page', action: :show, on: :member
  end

  namespace :admin do
    root to: "dashboard#index"

    resources :reports,   only: [:index, :show] do
      get   'page/:page',   action: :index, on: :collection
      get   'treat',        on: :member

      resources :tracks, only: [:show]
    end
  end

end
