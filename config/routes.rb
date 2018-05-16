Rails.application.routes.draw do
  get '/admin' => 'sessions#new'
  post '/admin' => 'sessions#create'
  get '/admin/logout' => 'sessions#destroy'

  get '/console' => 'console#status'
  get '/create_account' => 'create_acount#create_account'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match '/login' => 'login#login', via: :post
  match '/create' => 'login#create', via: :post
  match '/delete' => 'login#delete', via: :post
  match '/reset_password' => 'login#reset_password', via: :post

  match '/console/start_main' => 'console#start_main', via: :post
  match '/console/stop_main' => 'console#stop_main', via: :post
  match'/console/start_gateway' => 'console#start_gateway', via: :post
  match '/console/stop_gateway' => 'console#stop_gateway', via: :post

  get '/bot/get_gateway_status' => 'bot#get_gateway_status'
  get '/bot/get_main_status' => 'bot#get_main_status'
end
