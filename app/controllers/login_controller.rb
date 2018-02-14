require 'bcrypt'

class LoginController < ApplicationController

  def login
    # Parse request
    data = JSON.parse(request.body.read)
    login = data['login']
    password = data['password']

    # Find the user
    user = User.find_by(username: login)
    unless user
      user = User.find_by(email: login)
    end
    unless user
      head :not_found
    end

    # Check password
    if password == user.password
      response.status=(:accepted)
      jdata = {
        'password' => "password",
        'port' => "100"
      }
      render json: jdata
    else
      head :forbidden
    end
  end

  def create_account
    data = JSON.parse(request.body.read)
    username = data['username']
    email = data['email']
    password = data['password']

    unless username && email && password
      head :bad_request
    end

    if User.find_by(username: username)
      render plain: "Username taken"
      head :conflict
      return
    end

    if User.find_by(email: email)
      render plain: "Email in use"
      head :conflict
      return
    end

    new_user = User.new
    new_user.username = username
    new_user.email = email
    new_user.password = password
    new_user.save!

    head :created
  end

  def delete_user
    # Parse request
    data = JSON.parse(request.body.read)
    login = data['login']
    password = data['password']

    # Find the user
    user = User.find_by(username: login)
    unless user
      user = User.find_by(email: login)
    end
    unless user
      head :not_found
      return
    end
    if user.password == password
      render plain: "User deleted!"
      user.destroy
    end
    if user.password != password
      render plain: "Incorrect Password!"
      head :forbidden
    end
  end

  def reset_password
    data = JSON.parse(request.body.read)
    email = data['email']
    user = User.find_by(email: email)
    UserMailer.reset(user).deliver_now
  end
end
