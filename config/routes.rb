Rails.application.routes.draw do
  namespace :site do
    get "welcome/index"
    resources :search, only: [ :index ]
    post "answer", to: "answer#answer_correction", as: "answer"
  end
  namespace :users_backoffice do
    get "welcome/index"
  end
  namespace :admins_backoffice do
    get "force_admin_login"
    get "welcome/index"
    resources :admins
    resources :subjects
    resources :questions
  end
  get "site/index"
  devise_for :users
  devise_for :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "site/welcome#index"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
