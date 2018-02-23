# Handles admin session login
class SessionsController < ApplicationController
  protect_from_forgery with: :exception

  def new; end

  def create
    admin = Admin.find_by_username params[:login]
    unless admin && admin.authenticate(params[:password])
      response.status = :bad_request
      redirect_to admin_url
      return
    end
    session[:user_id] = admin.id
    redirect_to console_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to admin_url
  end
end
