Rails.application.routes.draw do
  get 'home/index'
  root 'home#index'
  get 'home/info'
  get 'home/export'
  
end
