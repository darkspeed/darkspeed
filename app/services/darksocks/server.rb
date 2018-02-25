# Interfacing to the underlying C libraries
module Darksocks
  # Controls the running ds-server or ss-server processes.
  class Server
    @service_path = Rails.root.join 'app/services/darksocks/'

    # Start DarkSocks server
    # @param profile [Symbol] The profile to use.
    def self.start(profile)
      write(make_config(profile), profile)
      # Get options
      path = path_for profile
      exec = Profile.global :command
      plugin = Profile.global :plugin
      opts = Profile.global :opts
      # Spawn process
      command = %(#{exec} -c #{path} --plugin #{plugin} --plugin-opts "#{opts}")
      startup command, profile
    end

    # Shutdown DarkSocks server
    # @param profile [Symbol] The profile to kill.
    def self.shutdown(profile)
      return nil unless running? profile
      pid = read_pid(profile)
      raise if pid.zero?
      Process.kill('SIGINT', pid)
      path = pid_path profile
      File.delete path if File.exist? path
    end

    # Status of a profile
    # @param profile [Symbol] The profile to use.
    def self.running?(profile)
      return true if read_pid profile
      false
    end

    # Generate a JSON configuration
    # @param profile [Symbol] The profile to use. Ex: main or gateway.
    # @return The JSON data created.
    def self.make_config(profile)
      profile = Profile.config_for(profile)
      options = Profile.config_for(:global)
      JSON(
        server: options[:host], server_port: profile[:port].to_s,
        local_address: '0.0.0.0', local_port: '8080',
        password: profile[:password], method: options[:cipher],
        timeout: options[:timeout], fast_open: false
      )
    end

    private_class_method

    def self.read_pid(profile)
      path = pid_path profile
      return nil unless File.exist? path
      File.new(path).read.to_i
    end

    def self.pid_path(profile)
      Rails.root.join "tmp/#{profile}.pid"
    end

    def self.write(config, symbol)
      file = File.open(path_for(symbol), 'w')
      file.write config
      file.close
    end

    def self.startup(command, profile)
      pid_flag = " -f #{pid_path profile}"
      fork do
        exec command.concat pid_flag
      end
    end

    def self.path_for(symbol, ext = 'json')
      @service_path.join "#{symbol}.#{ext}"
    end
  end
end
