# @abstract Manage configuration of the underlying DarkSocks processes.
# @author Aaron Sutton <aaronjsutton@icloud.com>#
#
# @example Get the main profile
#   Profile.read :main # => {:password: "password", port: 8796}
#
class Profile
  @@filepath = "#{Rails.root}/config/darksocks.yml"
  # Read the YAML configuration file.
  #
  # @param profile [Symbol] The profile to read from the configuration file.
  # @return [Hash] A hash containing the port and password of the profile.
  def self.read(profile)
    config = (Psych.load_file(@@filepath).symbolize_keys)
    return config[profile].symbolize_keys if config[profile]
    nil
  end
end
