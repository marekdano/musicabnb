require "rails_helper"

feature "Member with profile" do
  let(:member) { FactoryGirl.create(:member) }

  before do 
    login_as(member, :scope => :member)
  end

  scenario "delete his/her account" do
    visit profile_path
    click_link "Delete your account"
    click_button "OK"
    expect(page).to have_content("Log In")
    expect(page).to have_content("Sign Up")
  end
end