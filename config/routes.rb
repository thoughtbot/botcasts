Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :podcasts, only: :index do
    resources :episodes, only: [:index, :show]
    resources :search_results, only: :index
  end

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "podcasts#index"
end
