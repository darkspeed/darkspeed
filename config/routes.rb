Rails.application.routes.draw do
  get '/admin' => 'sessions#new'
  post '/admin' => 'sessions#create'
  get '/admin/logout' => 'sessions#destroy'

  get '/console' => 'console#status'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match '/login' => 'login#login', via: :post
  match '/create' => 'login#create', via: :post
  match '/delete' => 'login#delete', via: :post
  match '/reset_password' => 'login#reset_password', via: :post
end
