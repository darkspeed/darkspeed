require 'rails_helper'
include Faker

RSpec.describe LoginController, type: :controller do
  describe "user creation: " do
    before :each do
      @user = Fabricate.build(:user)
      @user_data = {
        username: @user.username,
        email: @user.email,
        password: @user.password,
        password_confirmation: @user.password_confirmation
      }
    end

    it "creates a user" do
     post :create, as: :json, params: @user_data
     assert_response :created
    end

    it "checks for duplicate users" do
      for user in 1..2 do
        post :create, as: :json, params: @user_data
        if user == 1
          assert_response :created
        else
          assert_response :bad_request
          response_error = JSON.parse response.body, symbolize_names: true
          expect(response_error[:username]).to include "has already been taken"
        end
      end
    end

    it "checks for no-match passwords" do
      no_match_user = @user_data
      no_match_user[:password_confirmation] = "nomatch"

      post :create, as: :json, params: no_match_user
      assert_response :bad_request
      response_error = JSON.parse response.body, symbolize_names: true
      expect(response_error[:password_confirmation]).to include "doesn't match Password"
    end

    it "checks for blank password" do
      no_pass_user = @user_data
      no_pass_user[:password] = ""

      post :create, as: :json, params: no_pass_user
      assert_response :bad_request
      response_error = JSON.parse response.body, symbolize_names: true
      expect(response_error[:password]).to include "can't be blank"
    end

    after :all do
      Fallout.unique.clear
    end
  end

  describe "authentication: " do
    before :each do
      @password = Internet.password
      @user = Fabricate(:user, password: @password, password_confirmation: @password)
    end

    it "logs in a user by username" do
      post :login, as: :json, params: {login: @user[:username], password: @password}
      assert_response :accepted
    end

    it "logs in a user by email" do
      post :login, as: :json, params: {login: @user[:email], password: @password}
      assert_response :accepted
    end

    it "rejects an email that does not exist" do
      post :login, as: :json, params: {login: "not@valid.mail", password: @password}
      assert_response :not_found
    end

    it "rejects a username that does not exist" do
      post :login, as: :json, params: {login: "anonymous", password: @password}
      assert_response :not_found
    end

    it "rejects an incorrect password" do
      post :login, as: :json, params: {login: @user[:email], password: "falsey"}
      assert_response :forbidden
    end
  end

  describe "user deletion: " do
    before :each do
      @password = Internet.password
      @user = Fabricate(:user, password: @password, password_confirmation: @password)
    end

    it "deletes a user" do
      post :delete, as: :json, params: {login: @user[:email], password: @password}
      assert_response :ok
    end

    it "rejects a user that does not exist" do
      post :delete, as: :json, params: {login: "mc_hammer", password: @password}
      assert_response :not_found
    end

    it "rejects an incorrect password" do
      post :delete, as: :json, params: {login: @user[:email], password: "cant_touch_this"}
      assert_response :forbidden
    end
  end
end
