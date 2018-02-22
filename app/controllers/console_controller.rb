# Displays the console for managing the server.
class ConsoleController < ApplicationController
  before_action :require_admin

  private

  def require_admin
    redirect_to admin_url unless logged_in?
  end
end
