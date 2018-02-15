require 'rails_helper'
include Faker

RSpec.describe LoginController, type: :controller do
  describe "user creations" do

    before :all do
      full_name = Fallout.unique.character
      @user_data = {
        username: Internet.user_name(full_name),
        email: Internet.email(full_name),
        password: Internet.password
      }
    end

    it "creates a unique user" do
      for user in 1..2 do
        post :create_account, as: :json, params: @user_data
        if user == 1
          assert_response :created
        else
          assert_response :conflict
        end
      end
    end

    it "logs in a user by username" do
      # Add user to DB
      expect(User.new(username: @user_data[:username], email: @user_data[:email], password: @user_data[:password]).save!).to be true
      post :login, as: :json, params: {login: @user_data[:username], password: @user_data[:password]}
      assert_response :accepted
    end

    after :all do
      Fallout.unique.clear
    end

  end
end
