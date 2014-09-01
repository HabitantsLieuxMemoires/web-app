Hlm::Application.routes.draw do
  mount_roboto
  root "home#index"

  match "/404" => "errors#error404", via: [ :get, :post, :patch, :delete ]

  get "logout",       to: "sessions#destroy",  as: "logout"
  get "login",        to: "sessions#new",      as: "login"
  get "signup",       to: "users#new",         as: "signup"
  get "profile",      to: "users#show",        as: "profile"

  get "search",       to: "search#index",      as: "search"

  get "/pages/*id",   to: 'pages#show',        as: :page, format: false

  resources :sessions,        only: [:new, :create]
  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :users,           only: [:new, :create, :show] do
    post :change_password,    on: :member
    post :change_avatar,      on: :member
  end

  resources :articles do
    get  :autocomplete, on: :collection
    post :search,       on: :collection
    get  :tags,         on: :collection
    get  :share,        on: :member

    resources :reports,  only: [:new, :create]
    resources :videos,   only: [:new, :create, :destroy]

    resources :comments, only: [:index, :new, :create] do
      get   'page/:page',   action: :index, on: :collection
    end

    resources :images,   only: [:new, :create, :destroy] do
      get   'select', on: :collection
    end
  end

  resources :themes, only: [:show] do
    get 'page/:page', action: :show, on: :member
  end

  resources :chronologies, only: [:show] do
    get 'page/:page', action: :show, on: :member
  end

  resources :tags, only: [:index, :show] do
    get 'page/:page', action: :show, on: :member
  end

  namespace :admin do
    root to: "dashboard#index"

    resources :users,     only: [:index] do
      get   'warn',           on: :member
      get   'ban',            on: :member
      post  'change_role',    on: :collection
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

  # Development only routes
  if Rails.env.development?

    # Emails visualisation
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
