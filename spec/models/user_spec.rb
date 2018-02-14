require 'rails_helper'

RSpec.describe User, type: :model do

  before :all do
    @user = User.new
  end

  it "creates fake users" do
    @user = Fabricate(:user)
    expect(@user.username).not_to be nil
    expect(@user.password_hash).not_to be nil
    expect(@user.email).not_to be nil
  end
end
