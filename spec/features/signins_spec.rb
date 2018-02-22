require 'rails_helper'

RSpec.feature 'Signins', type: :feature do

  before :each do
    @admin = Fabricate :admin
  end

  it 'signs me in'
end
