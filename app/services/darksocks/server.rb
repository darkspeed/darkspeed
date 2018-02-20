module Darksocks
  # Controls the running ds-server or ss-server processes.
  class Server
    def self.start(profile); end

    def self.stop(profile); end

    def self.running?(profile); end

    def self.make_config(profile)
      profile = Profile.read(profile)
      options = Profile.read(:global)
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

    def self.write(config, symbol)
      file = File.open "#{symbol}.json"
      file.write config
      file.close
    end

    def self.read_pid(file); end
  end
end
