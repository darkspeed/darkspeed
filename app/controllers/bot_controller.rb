class BotController < ApplicationController
  def get_main_status
    unless Darksocks::Server.status? :main
      render plain: "offline"
    else
      render plain: "online"
    end
  end
  def get_gateway_status
    unless Darksocks::Server.status? :gateway
      render plain: "offline"
    else
      render plain: "online"
    end
  end
end
