Rails.application.routes.draw do
  get 'sessions/new'

  get 'console/status'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match '/login' => 'login#login', via: :post
  match '/create' => 'login#create', via: :post
  match '/delete' => 'login#delete', via: :post
  match '/reset_password' => 'login#reset_password', via: :post
end
