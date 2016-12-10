Rails.application.routes.draw do

  root 'projects#index'
  devise_for :users

  resources :projects do
    resources :rewards, only: [:new, :create, :edit, :update, :destroy]
    resources :pledges
    resources :payments, only: [:new, :create]
  end

end
