Rails.application.routes.draw do

  get 'sessions/new'
  post 'sessions' => 'sessions#create'
  resources :users, except: [:index, :destroy]
  resources :teams, only: [:show, :index]
  resources :trades, except: [:destroy] do
    resources :offers
  end
  post 'trades/:id/cancel' => 'trades#cancel', as: :cancel_trade
  post 'trades/:trade_id/offers/:id/accept' => 'offers#accept', as: :trade_offer_accept
  get 'players/:id' => 'players#show', as: :player
  get 'home' => 'home#index', as: :home
  get 'about' => 'home#about'
  get 'signup' => 'users#new', as: :signup
  get 'login' => 'sessions#new', as: :login
  get 'logout' => 'sessions#destroy', as: :logout
  root 'home#index'

end
