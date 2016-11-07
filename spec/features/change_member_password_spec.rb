require "rails_helper"

feature "Member with profile" do
  let(:member) { FactoryGirl.create(:member) }

  scenario "changes his/her account when member is logged in" do
    login_as(member, :scope => :member)
    visit profile_path
    fill_in "member[password]", with: "123456"
    click_button "Save New Password"
    expect(page).to have_content("Password was successfully changed.")
  end

  scenario "changes his/her account when member is logged in and password is too short" do
    login_as(member, :scope => :member)
    visit profile_path
    fill_in "member[password]", with: "1234"
    click_button "Save New Password"
    expect(page).to have_content("New password was not saved.")
  end

  scenario "changes his/her account when member is NOT logged in" do
    visit profile_path
    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end