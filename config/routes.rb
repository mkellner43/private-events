Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'events#index'
  get '/users/:id', to: 'users#show'
  resources :events do
    member do
      post 'attend'
      post 'unattend'
    end
  end 
  # Defines the root path route ("/")
  # root "articles#index"
end
