require 'bcrypt'

class LoginController < ApplicationController

  def login
    # Parse request
    data = JSON.parse request.body.read, symbolize_names: true
    login = data[:login]
    password = data[:password]

    # Find the user
    user = User.find_by(username: login)
    user ||= User.find_by(email: login)

    # User not found
    unless user
      head :not_found
      return
    end

    # Password does not match
    unless user.authenticate password
      head :forbidden
      return
    end

    head :accepted

    # TODO: Method call to get server config from ds-server gem
    # Send config to client

  end

  # Refactor?
  def create_account
    # Parse request
    data = JSON.parse request.body.read, symbolize_names: true
    username = data[:username]
    email = data[:emai]
    password = data[:password]
    password_confirmation = data[:password_confirmation]

    # Create the new user
    new_user = User.new username: username, email: email
    new_user.password = password
    new_user.password_confirmation = password_confirmation

    # Save the user to the database
    unless new_user.save
      response.status = :bad_request
      render json: new_user.errors.as_json
      return
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
