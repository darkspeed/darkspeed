# Interfacing to the underlying C libraries
module Darksocks
  # Controls the running ds-server or ss-server processes.
  class Server
    @config_path = Rails.root.join 'app/services/darksocks/'

    def self.start(profile); end

    def self.stop(profile); end

    def self.running?(profile); end

    # Generate a JSON configuration
    # @param profile [Symbol] The profile to use. Ex: main or gateway.
    # @return The JSON data created.
    def self.make_config(profile)
      profile = Profile.config_for(profile)
      options = Profile.config_for(:global)
      JSON(
        server: profile[:host], server_port: profile[:port].to_s,
        local_address: '0.0.0.0', local_port: '8080',
        password: profile[:password], timeout: options[:timeout],
        method: options[:cipher], fast_open: options[:cipher],
        plugin: 'obfs-local',
        'plugin-opts' => 'obfs=http;obfs-host=www.bing.com'
      )
    end

    private_class_method

    # Writes a config file
    # @param config [String] The data to write.
    # @param symbol [Symbol] The name of the profile.
    def self.write(config, symbol)
      file = File.open(@config_path.join("#{symbol}.json"), 'w')
      file.write config
      file.close
    end

    def self.read_pid(file); end
  end
end
