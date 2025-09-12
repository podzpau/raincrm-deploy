Rails.application.routes.draw do
  devise_for :users
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "dashboard#index"

  resources :deals do
    collection do
      get :kanban
    end
    resources :messages, only: [:index, :create, :show]
    resources :documents, only: [:index, :show, :create, :destroy]
    member do
      patch :update_status
    end
  end

  resources :contacts
  resources :dashboard, only: [:index]
  
  # Demo route for Figma integration
  get 'figma-demo', to: 'dashboard#figma_demo', as: 'figma_demo'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
