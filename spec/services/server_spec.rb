RSpec.describe Darksocks::Server do

  before :all do
    ENV["DARKSPEED_HOSTNAME"] = "darkspeed.test"
    ENV["DARKSPEED_PASSWORD"] = "testpassword"
    @symbol = :main
    ['json', 'pid'].each do |ext|
      filepath = Rails.root.join "app/services/darksocks/#{@symbol}.#{ext}"
      File.delete filepath if File.exists? filepath
    end
    @profile = Profile.config_for @symbol
    @json = Darksocks::Server.make_config @symbol
  end

 it 'creates config JSON files' do
   expect(@json).not_to be nil
   config = JSON.parse(@json, symbolize_names: true)
   expect(config[:server_port].to_i).to eq @profile[:port]
   expect(config[:password]).to eq @profile[:password]
 end

 it 'writes a config file' do
   Darksocks::Server.write @json, @symbol
   expect(File.new(Rails.root.join "app/services/darksocks/#{@symbol}.json").read).to eq @json
 end

 it 'stops/starts' do
   Darksocks::Server.start @symbol
   expect(Darksocks::Server.running? @symbol).to be true
   Darksocks::Server.shutdown @symbol
   expect(Darksocks::Server.running? @symbol).to be false
 end
end
