Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users

  resources :pages, only: :index
  resources :contacts, only: [:new, :create]

  resources :alerts, only: %i[index new show create edit upvote update destroy] do
    collection do
      get :my_alerts
    end
    resources :assignments, only: %i[index new edit update]
    member do
      put "like", to: "alerts#like"
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
