Rails.application.routes.draw do

  get 'sessions/new'
  # Set Root Directory #
  root 'static_pages#home'

  # Set Static Page Directories #
  get 'about',    to: 'static_pages#about'
  get 'support',  to: 'static_pages#support'
  get 'contact',  to: 'static_pages#contact'

  # Set User Directories #
  get    'signup',  to: 'users#new'
  get    'login',   to: 'sessions#new'
  post   'login',   to: 'sessions#create'
  delete 'logout',  to: 'sessions#destroy'

  # Set Project Resources #
  resources :microposts, only: [:create, :destroy]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships,       only: [:create, :destroy]
end
