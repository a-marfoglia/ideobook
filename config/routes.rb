Rails.application.routes.draw do
  get 'notifications/index'

  root 'static_pages#home'
  #devise_for :users, controllers: { registrations: 'registrations' }
  devise_for :users, :controllers => { :registrations => 'registrations', confirmations: 'confirmations' }
  resources :users, only: [:show]
  resources :user_follow, only: [:new, :destroy]
  resources :micropost_follow, only: [:new, :destroy]
  resources :microposts do
  resources :comments, only: [:create, :destroy]
  end
  #devise_for :users, controllers: { confirmations: 'confirmations' }
  resources :avatar_uploads, only: [:update]
  resources :notifications, only: [:show, :index, :edit]
end
