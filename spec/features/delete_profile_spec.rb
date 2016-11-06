require "rails_helper"

feature "Member with profile" do
  let(:member) { FactoryGirl.create(:member) }

  before do 
    login_as(member, :scope => :member)
  end

  scenario "delete his/her account" do
    visit profile_path
    expect { click_link "Delete your account" }.to change(Profile, :count).by(-1)
    expect(page).to have_content("We are unhappy seeing you to leave.")
    expect(page).to have_content("Log In")
    expect(page).to have_content("Sign Up")
  end

end