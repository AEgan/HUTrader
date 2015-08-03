Rails.application.routes.draw do

  get 'sessions/new'
  post 'sessions' => 'sessions#create'
  resources :users, only: [:show, :new, :edit, :update, :create]
  resources :teams, only: [:show, :index]
  resources :trades, only: [:index, :show, :new, :edit, :update, :create] do
    resources :offers
  end
  post 'trades/:id/cancel' => 'trades#cancel', as: :cancel_trade
  get 'players/:id' => 'players#show', as: :player
  get 'home' => 'home#index', as: :home
  get 'about' => 'home#about'
  get 'signup' => 'users#new', as: :signup
  get 'login' => 'sessions#new', as: :login
  get 'logout' => 'sessions#destroy', as: :logout
  root 'home#index'

end
