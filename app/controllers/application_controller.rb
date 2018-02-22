# Manages app
class ApplicationController < ActionController::Base
  before_action :set_raven_context

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user])
  end

  def logged_in?
    current_user != nil
  end

  private

  def set_raven_context
    Raven.user_context(id: 'DarkSpeed User')
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end
