ApiIndicators::Application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :projects, only: [:index, :create, :show, :update, :destroy]
    resources :services, only: [:index, :create, :show, :update, :destroy]
    resources :indicators, only: [:index, :show, :update] do
      resources :events, only: [:index, :create, :show, :update, :destroy]
    end
    resources :statuses, only: :index
  end

  get "/api" => "api#show", as: :api_root

  resources :indicators, only: :show

  controller :sessions do
    get "login" => :new
    post "login" => :create
    get "logout" => :destroy
  end

  resources :users, except: :destroy
  resources :organizations, only: [:index, :show, :new, :create]

  resource :docs, only: :show

  root to: "indicators#index"
end
