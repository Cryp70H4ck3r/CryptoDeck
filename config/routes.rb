Rails.application.routes.draw do

  # Set Root Directory #
  root 'static_pages#home'

  # Set Static Page Directories #
  get 'about',    to: 'static_pages#about'
  get 'support',  to: 'static_pages#support'
  get 'contact',  to: 'static_pages#contact'

  # Set User Directories #
  get 'signup',   to: 'users#new'
end
