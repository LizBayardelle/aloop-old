Rails.application.routes.draw do
  
  	devise_for :users, :controllers => { registrations: 'registrations' }
	  resources :users, only: [:show]
	
  	get 'home/index'
  	root 'home#index'
  
  	get 'home/info'
  	get 'home/export'
    get 'home/kits'

    get 'kits/XR250_XR400'
    get 'kits/XR600'
    get 'kits/XR650L'
    get 'kits/replacement'
    get 'kits/rear_fenders_1'
    get 'kits/rear_fenders_2'
    get 'kits/graphics'

    get 'other/xr400mx'

  	resources :contacts
  	put "contacts/:id/archive" => "contacts#archive", as: "archive_contact"
    put "contacts/:id/unarchive" => "contacts#unarchive", as: "unarchive_contact"

  
end
