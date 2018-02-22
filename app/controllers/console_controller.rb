# Displays the console for managing the server.
class ConsoleController < ApplicationController
  before_action :require_admin
  include Darksocks
  private

  def require_admin
    redirect_to admin_url unless logged_in?
  end
  def start_main
    Darksocks::Server.start :main
  end
  def stop_main
    Darksocks::Server.shutdown :main
  end
  def start_gateway
    Darksocks::Server.start :gateway
  end
  def stop_gateway
    Darksocks::Server.shutdown :gateway
  end
end
