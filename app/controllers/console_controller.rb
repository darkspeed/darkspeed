class ConsoleController < ApplicationController
  before_action :require_admin

  private

  def require_admin
    unless logged_in?
      redirect_to admin_url
    end
  end
end
