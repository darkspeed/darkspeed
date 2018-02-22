require 'rails_helper'

RSpec.describe ConsoleController, type: :controller do

  describe "GET #status" do
    it "returns http success" do
      get :status
      expect(response).to have_http_status(:success)
    end
  end

end
