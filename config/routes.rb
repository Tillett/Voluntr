Rails.application.routes.draw do

  get 'volunteer_sessions/new'

  get 'volunteer_users/new'

  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/faq',   to: 'static_pages#faq'
  get '/reqsignup', to: 'request_users#new'
  resources :request_users
  resources :volunteer_users do
    member do
      post 'signal_interest'
    end
  end
  resources :notifications, only: [:show, :destroy]
  resources :request_posts
  resources :request_post_updates, only: [:create, :destroy]
  get '/notifications', to: 'notifications#show'
  resources :availabilities

  get '/reqpostcreation', to: 'request_posts#new'
  get '/volusers', to: 'volunteer_users#index'
  get '/requsers', to: 'request_users#index'
  get '/reqposts', to: 'request_posts#index'
  get '/reqlogin', to: 'request_sessions#new'
  post '/reqlogin', to: 'request_sessions#create'
  delete '/reqlogout', to: 'request_sessions#destroy'
  get '/volsignup', to: 'volunteer_users#new'
  get '/vollogin', to: 'volunteer_sessions#new'
  post '/vollogin', to: 'volunteer_sessions#create'
  delete '/vollogout', to: 'volunteer_sessions#destroy'
  get '/newreqpost', to: 'request_posts#new'
  get '/newavailability', to: 'availabilities#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end
