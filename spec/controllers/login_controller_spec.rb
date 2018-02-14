require 'rails_helper'
include Faker

RSpec.describe LoginController, type: :controller do
  describe "user creations" do

    before :all do
      full_name = Fallout.character
      @user_data = {
        username: Internet.user_name(full_name),
        email: Internet.email(full_name),
        password: Internet.password
      }
    end

    it "creates user POST data" do
      puts "\n#{@user_data}\n"
    end

    it "creates unique users" do
      for user in 1..2 do
        post :create_account, as: :json, params: @user_data
        if user == 1
          assert_response :created
        else
          assert_response :conflict
        end
      end
    end


  end
end
