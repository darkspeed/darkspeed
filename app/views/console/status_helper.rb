# allows status.html.erb to use darksocks for server control
class StatusHelper
  include Darksocks
  def self.start_server(name)
    case name
    when 'main'
      Darksocks::Server.start :main
    when 'gateway'
      Darksocks::Server.start :gateway
    end
  end

  def self.stop_server(name)
    case name
    when 'main'
      Darksocks::Server.shutdown :main
    when 'gateway'
      Darksocks::Server.shutdown :gateway
    end
  end
end
