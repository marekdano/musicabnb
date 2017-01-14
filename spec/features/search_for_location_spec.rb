require 'rails_helper'

feature "Guest searches for locations" do
   
  before do
    # location with available dates defined
    member = FactoryGirl.create(:member)
    member.create_profile
    FactoryGirl.create_list(:location_with_available_dates, 15, title: "Location with Date 1", member: member)
    FactoryGirl.create_list(:location_with_available_dates, 15, title: "Location with Date 2", member: member)
    @first_location = Location.first
    @last_location = Location.last
  end

  scenario "by visiting index page with no search and clicks to view more" do
    visit locations_path
    expect(page).to have_content @first_location.title
    expect(page).not_to have_content @last_location.title
    click_link "Next"
    click_link "Next"
    expect(page).to have_content @last_location.title
    expect(page).not_to have_content @first_location.title
  end

  scenario "by filling out search form and clicks to view more" do
    visit root_path
    expect(page).to have_button "Find Properties"

    fill_in "address", with: "Dublin, Ireland"
    fill_in "start_date", with: Date.tomorrow
    fill_in "end_date", with: Date.today + 2.days
    click_button "Find Properties"

    expect(page).to have_content @first_location.title
    expect(page).not_to have_content @last_location.title
    click_link "Next"
    click_link "Next"
    expect(page).to have_content @last_location.title
    expect(page).not_to have_content @first_location.title
  end

  scenario "by place and dates range" do
    member = FactoryGirl.create(:member)
    member.create_profile
    location_ny = FactoryGirl.create(:location, title: "New York Location with Date 1", member: member)
    FactoryGirl.create(:available_date, location: location_ny, date: Date.today + 3.days)
    FactoryGirl.create(:available_date, location: location_ny, date: Date.today + 5.days)

    location_d = FactoryGirl.create(:location, title: "Dublin Location with Date 1", member: member)
    FactoryGirl.create(:available_date, location: location_d, date: Date.today + 3.days)
    FactoryGirl.create(:available_date, location: location_d, date: Date.today + 5.days)

    visit root_path
    expect(page).to have_button "Find Properties"

    fill_in "address", with: "Dublin, Ireland"
    fill_in "start_date", with: Date.today + 3.days
    fill_in "end_date", with: Date.today + 5.days
    click_button "Find Properties"

    expect(page).to have_content("New York Location with Date 1")
    expect(page).to have_content("Dublin Location with Date 1")
    expect(page.all('h2').count).to eq 2
  end
end