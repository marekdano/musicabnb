require 'rails_helper'

feature "Guest searches for locations" do
  let(:member) { FactoryGirl.create(:member) }  

  before do
    # location with available dates defined
    FactoryGirl.create_list(:location_with_available_dates, 30)
    @first_location = Location.first
    @last_location = Location.last
  end

  scenario "by visiting index page with no search and clicks to view more" do
    visit locations_path
    expect(page).to have_content @first_location.description
    expect(page).not_to have_content @last_location.description
    click_link "Next"
    expect(page).to have_content @last_location.description
    expect(page).not_to have_content @first_location.description
  end

  scenario "by filling out search form and clicks to view more" do
    visit root_path
    expect(page).to have_button "Find Properties"

    fill_in "address", with: "Dublin, Ireland"
    fill_in "start_date", with: Date.today
    fill_in "end_date", with: Date.tomorrow
    click_button "Find Properties"

    expect(page).to have_content("My title")
    expect(page.all('h2', text: 'My title').count).to eq 2
    
    expect(page).to have_content @first_location.description
    expect(page).not_to have_content @last_location.description
    click_link "Next"
    expect(page).to have_content @last_location.description
    expect(page).not_to have_content @first_location.description
  end
end