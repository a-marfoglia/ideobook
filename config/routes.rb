Rails.application.routes.draw do
  root 'static_pages#home'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :users, only: [:show]
  resources :microposts do
    resources :comments, only: [:create]
  end
  resources :avatar_uploads, only: [:update]
end
