require "rails_helper"

feature "Signing in" do
  
  scenario "with Google from login page" do
    visit root_path
    expect(page).to have_content("Log In")
    click_link "Log In"
    click_link "Log in with Google"
    expect(page).to have_link "Log Out"

    member = Member.last
    expect(member.provider).to eq "google_oauth2"
    expect(member.uid).to eq "123456"
  end

  scenario "with Google from sign up page" do
    visit root_path
    expect(page).to have_content("Sign Up")
    click_link "Sign Up"
    click_link "Sign up with Google"
    expect(page).to have_link "Log Out"

    member = Member.last
    expect(member.provider).to eq "google_oauth2"
    expect(member.uid).to eq "123456"
  end
end