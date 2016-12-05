require "rails_helper"

feature "Member creates a location" do
  let(:member) { FactoryGirl.create(:member) }

  scenario "fill the form of a new location when a member is logged in" do
    login_as(member, :scope => :member)
    visit new_location_path
    fill_in "location[title]", with: "Location title"
    fill_in "location[description]", with: "Location description"
    fill_in "location[address_1]", with: "Location address 1"
    fill_in "location[address_2]", with: "Location address 2"
    fill_in "location[city]", with: "Location city"
    fill_in "location[state]", with: "Location state"
    fill_in "location[postcode]", with: "Location postcode"
    fill_in "location[musical_instrument]", with: "Drums"
    fill_in "location[night_rate]", with: 30
    fill_in "location[guests]", with: 3
    click_button "Create Location"
    expect(page).to have_content("Location was successfully created.")
  end
end