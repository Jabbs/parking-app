Parkingapp::Application.routes.draw do
  
  match '/terms', to: 'static_pages#terms'
  match '/contact', to: 'static_pages#contact'
  match '/faq', to: 'static_pages#faq'
  match '/about', to: 'static_pages#about'
  match '/help', to: 'static_pages#help'
  match '/how_it_works', to: 'static_pages#how_it_works'
  match '/checkout', to: 'reservations#checkout', via: :get
  match '/checkout', to: 'reservations#purchase', via: :post
  match '/reservations_at_my_spot', to: 'listings#index2', via: :get

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
  resources :verifications, only: [:show]
  resources :password_resets, only: [:new, :create, :edit, :update]
  root :to => 'sessions#new'

end
