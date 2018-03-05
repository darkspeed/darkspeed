require 'rails_helper'

RSpec.feature 'console', type: :feature do
  before :each do
    @password = Faker::Internet.password
    @admin = Fabricate :admin, password: @password
  end

  it 'logs in admin console' do
    results = {
      @password => 'Main server',
      'fake' => 'DarkSpeed Administrator'
    }
    results.each do |password, content|
      visit admin_url
      fill_in 'login', with: @admin.username
      fill_in 'password', with: password
      click_button 'Open Console'
      expect(page).to have_content content
    end
  end

  after :all do
    DrWho.unique.clear
  end
end
