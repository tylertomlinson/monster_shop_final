Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get :root, to: 'welcome#index'

  resources :merchants do
    resources :items, only: [:index]
  end

  # get '/merchants/items', to: merchants/items#index

  resources :items, only: [:index, :show] do
    resources :reviews, only: [:new, :create]
  end

  # get '/items', to: 'items#index'
  # get '/items/:id', to: 'items#show'
  # get /items/reviews/new, to: 'items/reviews#new'
  # post /items/reviews, to: 'items/reviews#create'

  resources :reviews, only: [:edit, :update, :destroy]

  # get '/reviews/:id/edit', to: 'reviews#edit'
  # patch '/reviews/:id', to: 'reviews#update'
  # delete '/reviews/:id', to: 'reviews#destroy'

  get '/cart', to: 'cart#show'
  post '/cart/:item_id', to: 'cart#add_item'
  delete '/cart', to: 'cart#empty'
  patch '/cart/:change/:item_id', to: 'cart#update_quantity'
  delete '/cart/:item_id', to: 'cart#remove_item'

  # resources :cart, only: [:show, :create, :destroy, :update]
  # could have cart inheriting multiple controllers for best setup

  get '/registration', to: 'users#new', as: :registration
  resources :users, only: [:create, :update]
  patch '/user/:id', to: 'users#update'

  # can create namespace for this as well
  get '/profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit'
  get '/profile/edit_password', to: 'users#edit_password'
  post '/orders', to: 'user/orders#create'
  get '/profile/orders', to: 'user/orders#index'
  get '/profile/orders/:id', to: 'user/orders#show'
  delete '/profile/orders/:id', to: 'user/orders#cancel'
  # resources profile do
  #   resources :orders, only: [:index, :show, :destroy ]
  # end

  # resources :registration, only: [:new]
  # resources :users, only: [:new, :create, :update]
  # resources :orders, only: [:create]
  # post '/users', to: users#create

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#login'
  get '/logout', to: 'sessions#logout'

  namespace :merchant do
    get '/', to: 'dashboard#index', as: :dashboard
    resources :orders, only: :show
    resources :discounts, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :items, only: [:index, :new, :create, :edit, :update, :destroy]
    put '/items/:id/change_status', to: 'items#change_status'
    get '/orders/:id/fulfill/:order_item_id', to: 'orders#fulfill'
  end

  namespace :admin do
    get '/', to: 'dashboard#index', as: :dashboard
    resources :merchants, only: [:show, :update]
    resources :users, only: [:index, :show]
    patch '/orders/:id/ship', to: 'orders#ship'
  end
end
