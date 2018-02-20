RSpec.describe Darksocks do

  before :all do
    ENV["DARKSPEED_HOSTNAME"] = "darkspeed.test"
    ENV["DARKSPEED_PASSWORD"] = "testpassword"
    @symbol = :main
    @profile = Profile.read @symbol
  end

 it 'creates config JSON files' do
   json = Darksocks::Server.make_config @symbol
   expect(json).not_to be nil
   config = JSON.parse(json, symbolize_names: true)
   expect(config[:server_port].to_i).to eq @profile[:port]
   expect(config[:password]).to eq @profile[:password]
 end

 describe 'process stop/start' do
   it 'starts'
   it 'stops'
   it 'gets status'
 end
end
