Rails.application.routes.draw do
  get 'sessions/new'

  get 'sessions/destroy'

  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get '/faq',   to: 'static_pages#faq'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end
