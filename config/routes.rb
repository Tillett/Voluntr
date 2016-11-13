Rails.application.routes.draw do

  get 'request_post_jobs/new'

  get 'volunteer_sessions/new'

  get 'volunteer_users/new'

  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/faq',   to: 'static_pages#faq'
  get '/debugreview', to: 'static_pages#debugreview'
  get '/debugrequestreview', to: 'static_pages#debugrequestreview'
  get '/reqsignup', to: 'request_users#new'
  resources :request_users do
    member do
      get :followers
    end
  end
  resources :user_scorecards
  resources :request_user_scorecards
  resources :volunteer_users do
    member do
      post 'signal_interest'
      get :following
    end
  end
  resources :relationships,       only: [:create, :destroy]
  resources :notifications, only: [:show, :destroy]
  resources :request_posts
  resources :request_post_updates, only: [:create, :destroy]
  get '/notifications', to: 'notifications#show'
  resources :availabilities
  resources :request_post_jobs do
    member do
      post 'user_sig_interest'
      post 'assoc_with_user'
    end
  end
  get '/reqpostcreation', to: 'request_posts#new'
  get '/volusers', to: 'volunteer_users#index'
  get '/requsers', to: 'request_users#index'
  get '/reqposts', to: 'request_posts#index'
  get '/volreview', to: 'user_scorecards#edit'
  get '/reqlogin', to: 'request_sessions#new'
  post '/reqlogin', to: 'request_sessions#create'
  delete '/reqlogout', to: 'request_sessions#destroy'
  get '/volsignup', to: 'volunteer_users#new'
  get '/vollogin', to: 'volunteer_sessions#new'
  post '/vollogin', to: 'volunteer_sessions#create'
  delete '/vollogout', to: 'volunteer_sessions#destroy'
  get '/newreqpost', to: 'request_posts#new'
  get '/newavailability', to: 'availabilities#new'
  get '/following', to: 'volunteer_users#following'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end
