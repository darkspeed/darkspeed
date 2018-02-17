require 'bcrypt'

class LoginController < ApplicationController
  before_action do
    @data = JSON.parse request.body.read, symbolize_names: true
  end

  def find_user_by(login)
    user = User.find_by(username: login)
    user ||= User.find_by(email: login)
    head :not_found unless user
    return user
  end

  def user_auth?(user, password)
    unless user.authenticate password
      head :forbidden
      return false
    end
    return true
  end

  def login
    # Find and authenticatethe user
    user = find_user_by @data[:login]
    return unless user && user_auth?(user, @data[:password])
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
    user = find_user_by @data[:login]
    return unless user && user_auth?(user, @data[:password])
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
