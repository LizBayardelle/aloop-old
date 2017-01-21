Rails.application.routes.draw do
  
  get 'other/xr400mx'

  	devise_for :users, :controllers => { registrations: 'registrations' }
	resources :users, only: [:show]
	
  	get 'home/index'
  	root 'home#index'
  
  	get 'home/info'
  	get 'home/export'
    get 'home/graphics'

  	resources :contacts
  	put "contacts/:id/archive" => "contacts#archive", as: "archive_contact"
    put "contacts/:id/unarchive" => "contacts#unarchive", as: "unarchive_contact"

  
end
