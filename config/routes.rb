Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: :show
  resources :events do
    resources :comments, only: [:create, :destroy]
  end
  post '/events/:id/participate', to: 'events#participate'
  delete '/events/:id/cancel', to: 'events#cancel'
end
