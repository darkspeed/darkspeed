require 'rails_helper'

RSpec.describe User, type: :model do

  before :all do
    @user = User.new
  end

  it "interacts with the db" do
    @user = Fabricate(:user)
    expect(@user.username).not_to be nil
    expect(@user.email).not_to be nil

    expect(@user.save).to be true
    expect(User.find_by(username: @user.username)).to_not be nil
    expect(User.find_by(email: @user.email)).to_not be nil

    expect(@user.destroy).not_to be false
    expect(@user.destroyed?).to be true
  end
end
