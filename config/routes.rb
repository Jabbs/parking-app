Parkingapp::Application.routes.draw do
  
  match '/checkout', to: 'reservations#checkout', via: :get
  match '/checkout', to: 'reservations#purchase', via: :post

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  resources :searches, only: [:new, :create, :show]
  resources :leases, only: [:new, :create]
  resources :listings, only: [:index, :show, :new, :edit, :create, :destroy]
  resources :spots, only: [:index, :new, :edit, :create]
  resources :buildings
  resources :users, only: [:new, :create, :show]
  resources :reservations, only: [:create, :destroy, :index, :show]
  root :to => 'sessions#new'

end
