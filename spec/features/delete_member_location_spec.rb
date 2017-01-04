require 'rails_helper'

feature "Member with own location" do
  let(:member) { FactoryGirl.create(:member) }
  let(:location) { FactoryGirl.create(:location)}

  scenario "deletes his/her location when he/she is logged in" do
    # Log in a member who has a location
    login_as(location.member, :scope => :member)
    visit member_locations_path
    expect(page).to have_content("My title")
    click_link "Delete" 
    expect(page).to have_content("Location was successfully destroyed.")
  end

  scenario "tries to display location of another member" do
    # Log in a member who has no location
    login_as(member, :scope => :member)
    visit member_locations_path
    expect(page).not_to have_content("My title")
  end

  scenario "tries to display location when he/she is NOT logged in" do
    visit member_locations_path
    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end