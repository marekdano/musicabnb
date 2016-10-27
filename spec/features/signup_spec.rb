require 'rails_helper'

feature "signing up" do
  let(:member) { FactoryGirl.build(:member) }

  def fill_in_signup_fields
    fill_in "member[name]", with: member.name
    fill_in "member[email]", with: member.email
    fill_in "member[password]", with: member.password
    click_button "Sign up"
  end 

  scenario "with name, email and password" do
    visit root_path
    click_link "Sign Up"
    fill_in_signup_fields
    expect(page).to have_content("You have signed up successfully.")
  end

  scenario "without name, email and password" do
    visit root_path
    click_link "Sign Up"
    # No name, email and password is filled in
    click_button "Sign up"
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content("Name can't be blank")
  end

  scenario "without name" do
    visit root_path
    click_link "Sign Up"
    # No name filled
    fill_in "member[email]", with: member.email
    fill_in "member[password]", with: member.password    
    click_button "Sign up"
    expect(page).to have_content("Name can't be blank")
  end

end