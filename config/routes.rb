Rails.application.routes.draw do

  root 'projects#index'
  devise_for :users
  
end
