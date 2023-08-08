Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  root "users#index"

  resources :users, only: [:index, :show] do
    namespace :api do
      namespace :v1 do
        resources :posts, only: [:index] do
          resources :comments, only: [:index, :create]
        end
      end
    end
    resources :posts, only: [:index, :new, :show, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create, :destroy]
    end
  end
  get '/sign_out_user', to: 'users#sign_out_user', as: 'sign_out_user'
end

