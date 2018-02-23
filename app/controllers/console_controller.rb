# Displays the console for managing the server.
class ConsoleController < ApplicationController
  before_action :require_admin
  include Darksocks

  def require_admin
    redirect_to admin_url unless logged_in?
  end

  def start_main
    Darksocks::Server.start :main
    redirect_to console_url
  end

  def stop_main
    Darksocks::Server.shutdown :main
    redirect_to console_url
  end

  def start_gateway
    Darksocks::Server.start :gateway
    redirect_to console_url
  end

  def stop_gateway
    Darksocks::Server.shutdown :gateway
    redirect_to console_url
  end
end
