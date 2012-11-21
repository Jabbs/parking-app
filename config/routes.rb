Parkingapp::Application.routes.draw do

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  resources :leases, only: [:new, :create]
  resources :listings, only: [:index, :show, :new, :edit, :create]
  resources :spots, only: [:index, :new, :edit, :create]
  resources :buildings
  resources :users, only: [:new, :create]
  root :to => 'users#new'

end
