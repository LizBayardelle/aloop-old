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

  resources :items
  get 'tags/:tag', to: 'items#index', as: :tag
  resources :order_items, only: [:create, :update, :destroy]
  resource :cart, only: [:show]

  resources :contacts
  put "contacts/:id/archive" => "contacts#archive", as: "archive_contact"
  put "contacts/:id/unarchive" => "contacts#unarchive", as: "unarchive_contact"

  resources :photos
  put "photos/:id/approve" => "photos#approve", as: "approve_photo"
  put "photos/:id/unapprove" => "photos#unapprove", as: "unapprove_photo"
  
  mount Shoppe::Engine => "/shoppe"
  get "product/:permalink", to: "products#show", as: "product"
  post "product/:permalink", to: "products#buy", as: "buy"
  resources :products, only: [:index]
  post "product/:permalink", to: "products#buy"
  get "basket", to: "orders#show"
  delete "basket", to: "orders#destroy"
  match "checkout", to: "orders#checkout", as: "checkout", via: [:get, :patch]
  match "checkout/pay", to: "orders#payment", as: "checkout_payment", via: [:get, :post]
  match "checkout/confirm", to: "orders#confirmation", as: "checkout_confirmation", via: [:get, :post]
end
