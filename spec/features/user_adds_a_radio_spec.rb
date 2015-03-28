# spec/features/user_adds_a_radio.rb

require "rails_helper"
require 'capybara/rspec'

feature 'User adds a radio' do
  scenario 'user creates a new radio list' do
    visit '/radio_lists/new'
    fill_in 'radio_list_name', with: 'BBC radio 2'
    fill_in 'radio_list_description', with: 'Best popular UK radio'
    fill_in 'radio_list_radio_url', with: 'http://bbc.co.uk/radio/listen/live/r2.asx '
    click_button 'Salva'
    
    expect(page).to  have_text 'Radio list was successfully created.'
  end
end