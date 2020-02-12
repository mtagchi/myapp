Rails.application.routes.draw do
  get '/mypage', to: 'home#index'
  root to: 'events#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, only: [:show, :destroy]
  resources :events do
    resources :comments, only: [:create, :destroy]
  end
  post '/events/:id/participate', to: 'events#participate'
  delete '/events/:id/cancel', to: 'events#cancel'
end
