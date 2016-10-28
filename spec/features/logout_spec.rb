require 'rails_helper'

feature "loging out" do
  let(:member) { FactoryGirl.create(:member) }

  before :each do
    login_as(member, :scope => :member)
  end

  scenario "of the logged in member" do
    visit root_path
    expect(page).not_to have_content("Sign Up")
    click_link "Log Out"
    expect(page).to have_content("Signed out successfully.")
  end

end