require "rails_helper"

feature "Member creates a location" do
  let(:member) { FactoryGirl.create(:member) }

  before do   
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
  end

  scenario "fill the form of a new location when a member is logged in" do
    expect(page).to have_content("Location was successfully created.")

    visit locations_path
    expect(page).to have_content("Location title")
    expect(page).to have_content("Location description")
    expect(page).to have_content("Drums")
    expect(page).to have_content("30")
    expect(page).to have_content("3")
  end

  scenario "by entering a description and uploading images" do
    expect(page).to have_content("Location was successfully created.")
    expect(page).to have_content "Add Pictures"
  
    picture_1_path = 'spec/fixtures/files/avatar.jpg' 

    attach_file "location[location_images_attributes][0][picture]", picture_1_path
    click_button "UPDATE & SAVE"

    expect(LocationImage.count).to eq 1
    expect(LocationImage.first.picture_order).to eq 1
  end
end

feature "Guest attempts to create a location" do
  let(:member) { FactoryGirl.create(:member) }

  scenario "opens the location form when a member is not logged in" do
    visit new_location_path
    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end