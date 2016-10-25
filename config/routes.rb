Rails.application.routes.draw do
  get 'volunteer_sessions/new'

  get 'volunteer_users/new'

  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/faq',   to: 'static_pages#faq'
  get '/reqsignup', to: 'request_users#new'
  resources :request_users
  resources :volunteer_users
  resources :request_posts
  get '/reqpostcreation', to: 'request_posts#new'
  get '/reqlogin', to: 'request_sessions#new'
  post '/reqlogin', to: 'request_sessions#create'
  delete '/reqlogout', to: 'request_sessions#destroy'
  get '/volsignup', to: 'volunteer_users#new'
  get '/vollogin', to: 'volunteer_sessions#new'
  post '/vollogin', to: 'volunteer_sessions#create'
  delete '/vollogout', to: 'volunteer_sessions#destroy'
  get '/newreqpost', to: 'request_posts#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end
