Hlm::Application.routes.draw do
  root "home#index"

  get "logout", to: "sessions#destroy",  as: "logout"
  get "login",  to: "sessions#new",      as: "login"
  get "signup", to: "users#new",         as: "signup"

  get "search", to: "search#index",      as: "search"

  resources :users,           only: [:new, :create]
  resources :sessions,        only: [:new, :create]
  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :articles do
    get  :autocomplete, on: :collection
    post :search,       on: :collection
    get  :share,        on: :member

    resources :reports,  only: [:new, :create]
    resources :videos,   only: [:new, :create, :destroy]

    resources :comments, only: [:index, :new, :create] do
      get   'page/:page',   action: :index, on: :collection
    end

    resources :images,   only: [:new, :create, :destroy] do
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

    resources :users,     only: [] do
      get 'warn',           on: :member
      get 'ban',            on: :member
    end

    resources :articles,  only: [:index, :show, :destroy] do
      get 'page/:page',     action: :index, on: :collection
      get 'feature',        on: :member
      get 'unfeature',      on: :member

      resources :images,  only: [:show] do
        get 'restore',      on: :member
      end

      resources :videos,  only: [:show] do
        get 'restore',      on: :member
      end
    end

    resources :comments,  only: [:index, :destroy] do
      get 'page/:page',     action: :index, on: :collection
    end

    resources :shares,    only: [:index] do
      get 'page/:page',     action: :index, on: :collection
    end

    resources :reports,   only: [:index, :show] do
      get   'page/:page',   action: :index, on: :collection
      get   'treat',        on: :member
    end

    resources :features,  only: [:index, :new, :create, :edit, :update]
    resources :tracks,    only: [:show]
  end

end
