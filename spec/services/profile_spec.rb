RSpec.describe Profile do
  before :each do
    @global = Profile.read(:global)
    ENV["DARKSPEED_HOSTNAME"] = 'darkspeed.test'
  end

  it 'reads the configuration file' do
    profile = Profile.read :gateway
    expect(profile).not_to be nil
    expect(profile[:password]).to eq 'gateway'
    expect(profile[:port]).to eq 5456
  end

  it 'returns a nil profile' do
    profile = Profile.read :not_real
    expect(profile).to be nil
  end

  it 'returns the executable' do
    expect(@global[:executable]).not_to be nil
  end

  it 'returns the cipher' do
    expect([:cipher]).not_to be nil
  end

  it 'preprocesses ERB' do
    expect(@global[:host]).to eq(ENV["DARKSPEED_HOSTNAME"])
  end
end
