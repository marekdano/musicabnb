require 'rails_helper'

feature "signing in" do
  let(:member) { FactoryGirl.create(:member) }

  def fill_in_signin_fields
    fill_in "member[email]", with: member.email
    fill_in "member[password]", with: member.password
    click_button "Log In"
  end

  scenario "visiting the site to sign in with an email and password" do
    visit root_path
    click_link "Log In"
    fill_in_signin_fields
    expect(page).to have_content("Signed in successfully.")
  end

  scenario "visiting the site to sign in with an email only" do
    visit root_path
    click_link "Log In"
    fill_in "member[email]", with: member.email
    # the password field is empty
    click_button "Log In"
    expect(page).to have_content("Invalid Email or password.")
  end

  scenario "visiting the site to sign in with no email and password" do
    visit root_path
    click_link "Log In"
    # email and password fields are empty
    click_button "Log In"
    expect(page).to have_content("Invalid Email or password.")
  end

end