Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :contacts, only: [:new, :create]

  resources :alerts do
    resources :assignments, only: %i[index new edit update]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
