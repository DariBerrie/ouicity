Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'
  root to: "pages#home"

  devise_for :users

  resources :pages, only: :index
  resources :contacts, only: [:new, :create]
  # Chatroom routes
  resources :chatrooms, only: :show do
    resources :chat_messages, only: :create
  end

  resources :alerts, only: %i[index new show create edit upvote update destroy] do
    collection do
      get :my_alerts
    end
    resources :assignments, only: %i[index new edit update]
    member do
      put "like", to: "alerts#like"
    end
  end


  namespace :intake do
      resources :categories, only: %i[new create]
      resources :details, only: %i[new create]
  end

  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
