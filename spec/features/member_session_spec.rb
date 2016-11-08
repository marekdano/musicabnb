require 'rails_helper'

feature "member session" do
  let(:member) { FactoryGirl.create(:member) }

  scenario "member visits the site to log in" do
    visit root_path
    click_link "Log In"
    fill_in "member[email]", with: member.email
    fill_in "member[password]", with: member.password
    click_button "Log in"
    expect(page).to have_content("Signed in successfully.")
  end

  scenario "member logs out of site" do
    login_as(member, scope: :member)
    visit root_path
    click_link "Log Out"
    expect(page).to have_content("Signed out successfully.")
  end

  scenario "member logs in with Google account" do 
    google_member = Member.create(
      email: "jeanluc@picard.com", password: "password123", 
      provider: "google_oauth2", uid: "123456", 
      name: "Jean Luc Picard"
    )
    member_count = Member.count

    visit root_path
    click_link "Log In"
    click_link "Log in with Google"
    expect(page).to have_content("Successfully authenticated from Google account.")

    recount_member = Member.count
    expect(member_count).to eq recount_member
  end  
end