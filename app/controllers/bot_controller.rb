class BotController < ApplicationController
  def get_main_status
    unless Darksocks::Server.status? :main
      render plain: "online"
    else
      render plain: "offline"
    end
  end
  def get_gateway_status
    unless Darksocks::Server.status? :gateway
      render plain: "online"
    else
      render plain: "offline"
    end
  end
end
