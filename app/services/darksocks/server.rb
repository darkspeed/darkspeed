# Interfacing to the underlying C libraries
module Darksocks
  # Controls the running ds-server or ss-server processes.
  class Server
    @service_path = Rails.root.join 'app/services/darksocks/'

    def self.path_for(symbol, ext = 'json')
      @service_path.join "#{symbol}.#{ext}"
    end

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
      pid = startup(command, profile)
      store_pid pid, profile
      pid
    end

    def self.shutdown(profile)
      return nil unless running? profile
      pid = read_pid(profile)
      raise if pid == 0
      Process.kill('SIGINT', pid)
      File.delete path_for profile, 'pid'
    end

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
        server: profile[:host], server_port: profile[:port].to_s,
        local_address: '0.0.0.0', local_port: '8080',
        password: profile[:password], method: options[:cipher],
        timeout: options[:timeout], fast_open: false
      )
    end

    def self.read_pid(profile)
      path = path_for(profile, 'pid')
      return nil unless File.exist? path
      File.new(path).read.to_i
    end

    private_class_method

    def self.store_pid(pid, profile)
      pidfile = File.new(path_for(profile, 'pid'), 'w')
      pidfile.write pid
      pidfile.close
    end

    # Writes a config file
    # @param config [String] The data to write.
    # @param symbol [Symbol] The name of the profile.
    def self.write(config, symbol)
      file = File.open(path_for(symbol), 'w')
      file.write config
      file.close
    end

    def self.startup(command)
      pid = Process.spawn command
      Process.detach pid
      pid
    end
  end
end
