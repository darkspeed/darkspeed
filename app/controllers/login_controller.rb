require 'bcrypt'

class LoginController < ApplicationController
  before_action do
    @data = JSON.parse request.body.read, symbolize_names: true
  end

  def find_user_by(login)
    user = User.find_by(username: login)
    user ||= User.find_by(email: login)
    return user || nil
  end

  def login
    login = @data[:login]
    password = @data[:password]

    # Find the user
    user = find_user_by login
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

    # TODO: Method call to get server config from config file
    # Send config to client
  end

  # Refactor?
  def create
    # Create the new user
    new_user = User.new username: @data[:username],
                        email: @data[:email],
                        password: @data[:password],
                        password_confirmation: @data[:password_confirmation]

    # Save the user to the database
    unless new_user.save
      response.status = :bad_request
      render json: new_user.errors.as_json
      return
    end

    head :created
  end

  def delete
    login = @data[:login]
    password = @data[:password]

    # Find the user
    user = find_user_by login
    unless user
      head :not_found
      return
    end

    # Authenticate
    unless user.authenticate password
      head :forbidden
      return
    end

    # Delete the user
    unless user.destroy
      head :internal_server_error
      return
    end

    head :ok
  end

  # TODO: Refactor, SendGrid, and spec.
  def reset_password
  end
end
