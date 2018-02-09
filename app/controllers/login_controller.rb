class LoginController < ApplicationController
  def login
    data = JSON.parse(request.body.read)
    username = data['username']
    password = data['password']
    
  end
end
