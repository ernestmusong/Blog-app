Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :show, :create] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create, :destroy]
    end
  end
end


