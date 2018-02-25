require 'rails_helper'

RSpec.feature 'console', type: :feature do
  before :each do
    @password = 'password'
    @admin = Admin.new username: 'admin', password: @password
    @admin.save
  end

  it 'logs in admin console' do
    results = {
      @password => 'DarkSpeed Admin Console',
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

end
