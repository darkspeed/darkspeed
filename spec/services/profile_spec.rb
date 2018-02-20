RSpec.describe Profile do
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
    expect(Profile.global :executable).not_to be nil
  end

  it 'returns the cipher' do
    expect(Profile.global :cipher).not_to be nil
  end

  it 'returns the host' do
    expect(Profile.global :host).not_to be nil
  end
end
