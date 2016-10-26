require 'rails_helper'

feature "visiting the homepage" do
  scenario "the visitor sees the homepage with text" do
    visit root_path
    expect(page).to have_text("Book your perfect musical vacation")
    expect(page).to have_text("Explore With Us")
  end
end