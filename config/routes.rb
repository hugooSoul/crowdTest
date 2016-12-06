Rails.application.routes.draw do

  root 'projects#index'
  devise_for :users

  resources :projects

end
