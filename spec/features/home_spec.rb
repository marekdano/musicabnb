require 'rails_helper'

feature "visiting the homepage" do
  before do
    member = FactoryGirl.create(:member)
    member.create_profile
    @location1 = FactoryGirl.create(:location, member: member)
    @location2 = FactoryGirl.create(:location, member: member)
    @location3 = FactoryGirl.create(:location, member: member)
    @location4 = FactoryGirl.create(:location, member: member)
    @location5 = FactoryGirl.create(:location, member: member)
    @location6 = FactoryGirl.create(:location, member: member)
  end

  scenario "the visitor sees the homepage with text and three locations" do
    visit root_path
    expect(page).to have_text("Book your perfect musical vacation")
    expect(page).to have_text("Explore With Us")

    expect(page).to have_text(@location6.title)
    expect(page).to have_text(@location5.title)
    expect(page).to have_text(@location4.title)
    expect(page).not_to have_text(@location3.title)
    expect(page).not_to have_text(@location2.title)
    expect(page).not_to have_text(@location1.title)
  end
end