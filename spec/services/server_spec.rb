RSpec.describe Darksocks::Server do

  before :all do
    ENV["DARKSPEED_HOSTNAME"] = "darkspeed.test"
    ENV["DARKSPEED_PASSWORD"] = "testpassword"
    @symbol = :main
    %i{:json, :pid}.each do |ext|
      filepath = Rails.root.join "app/services/darksocks/#{@symbol}.#{ext.to_s}"
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

 describe 'process stop/start' do
   it 'starts' do
     Darksocks::Server.start :main
     expect(File.exists?(Rails.root.join "app/services/darksocks/main.pid")).to be true
   end
   it 'stops'
   it 'gets status'
 end
end
