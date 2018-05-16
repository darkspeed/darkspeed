require 'bcrypt'

# Manages DarkSpeed user login.
class LoginController < ApplicationController
  before_action do
    Raven.user_context(id: params[:username], email: params[:email])
  end

  # Find a user by a given login.
  # @param login [String] Email or username.
  # @return [User?] The user, nil if not found.
  # @note When a user is not found, a status of 404 is set.
  def find_user_by(login)
    user = User.find_by_username login
    user ||= User.find_by_email login
    head :not_found unless user
    user
  end

  def user_auth?(user, password)
    unless user.authenticate password
      head :forbidden
      return false
    end
    true
  end

  def login
    # Find and authenticatethe user
    user = find_user_by params[:login]
    return unless user && user_auth?(user, params[:password])
    response.status = :accepted
    render json: Profile.config_for(:main)
  end

  def create
    new_user = create_user
    # Save the user to the database
    unless new_user.save
      response.status = :bad_request
      render json: new_user.errors.as_json
      return
    end
    render plain: "Success"
  end


  def delete
    user = find_user_by params[:login]
    return unless user && user_auth?(user, params[:password])
    unless user.destroy
      head :internal_server_error
      return
    end
    head :ok
  end

  # TODO: Refactor, SendGrid, and spec.
  def reset_password; end

  private

  def create_user
    User.new username: params[:username],
             email: params[:email],
             password: params[:password],
             password_confirmation: params[:password_confirmation]
  end
end
