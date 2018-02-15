require 'bcrypt'

class LoginController < ApplicationController

  def login
    # Parse request
    data = JSON.parse request.body.read, symbolize_names: true
    login = data[:login]
    password = data[:password]
    puts "RECV LOGIN #{login}"

    # Find the user
    user = User.find_by(username: login)
    user ||= User.find_by(email: login)

    unless user
      head :not_found
      return
    end

    unless user.authenticate password
      head :forbidden
      return
    end

    head :accepted
  end

  # Refactor?
  def create_account
    data = JSON.parse request.body.read, symbolize_names: true
    username = data[:username]
    email = data[:emai]
    password = data[:password]

    if User.find_by(username: username)
      head :conflict
      return
    end

    if User.find_by(email: email)
      head :conflict
      return
    end

    new_user = User.new
    new_user.username = username
    new_user.email = email
    new_user.password = password
    new_user.password_confirmation = password

    unless new_user.save
      head :bad_request
    end

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
