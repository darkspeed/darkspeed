class BotController < ApplicationController
  def get_main_status
    status = Darksocks::Server.status? :main
    render plain: status
  end
  def get_gateway_status
    status = Darksocks::Server.status? :gateway
    render plain: status
  end
end
