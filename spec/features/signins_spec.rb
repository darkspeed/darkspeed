require 'rails_helper'

RSpec.feature 'Signins', type: :feature do

  before :each do
    @admin = Fabricate :admin
  end

  it 'logs in admin console'
end
