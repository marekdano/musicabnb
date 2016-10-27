require 'rails_helper'

feature "loging out" do
  let(:member) { FactoryGirl.create(:member) }

  def login_member 
    visit "/login"
    fill_in "member[email]", with: member.email
    fill_in "member[password]", with: member.password
    click_button "Log in"
  end 

  before :each do
    login_member
  end

  scenario "of the logged in member" do
    visit root_path
    expect(page).not_to have_content("Sign Up")
    click_link "Log Out"
    expect(page).to have_content("Signed out successfully.")
  end

end