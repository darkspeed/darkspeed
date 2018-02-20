RSpec.describe Profile do
  before :each do
    @global = Profile.config_for(:global)
    ENV["DARKSPEED_HOSTNAME"] = 'darkspeed.test'
  end

  it 'reads the configuration file' do
    profile = Profile.config_for :gateway
    expect(profile).not_to be nil
    expect(profile[:password]).to eq 'gateway'
    expect(profile[:port]).to eq 5456
  end

  it 'returns a nil profile' do
    profile = Profile.config_for :not_real
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
