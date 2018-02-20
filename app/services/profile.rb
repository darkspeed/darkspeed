# Manage configuration of the underlying DarkSocks processes.
# @author Aaron Sutton <aaronjsutton@icloud.com>#
#
# @example Get the main profile
#   Profile.config_for :main # => {:password: "password", port: 8796}
#
class Profile
  @filepath = Rails.root.join 'config/darksocks.yml'
  # Read the YAML configuration file.
  #
  # @param profile [Symbol] The profile to read from the configuration file.
  # @return [Hash] A hash containing the port and password of the profile.
  def self.config_for(profile)
    template = ERB.new File.new(@filepath).read
    config = Psych.load(template.result).symbolize_keys
    return config[profile].symbolize_keys if config[profile]
    nil
  end

  # Get a global configuration option
  # @param [Symbol] The option name
  # @return The option
  def self.global(property)
    Psych.load_file(@filepath).symbolize_keys[property]
  end
end
