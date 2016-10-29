require "rails_helper"

feature "Member with profile" do
  let(:member) { FactoryGirl.create(:member) }

  #communicate purpose upfront with Simple BDD
  scenario "member can create own profile" do
    Given "member can view profile form"
    When "member enters information about self"
    Then "member can see the information updated"
  end
  #define methods from scenario
  def member_can_view_profile_form
    login_as(member, :scope => :member)
    visit profile_path
    expect(page).to have_content("My Profile")
  end

  def member_enters_information_about_self
    fill_in "member[name]", with: "Laura Gaga"
    fill_in "member[profile_attributes][bio]", with: "I'm terrible nice girl."
    fill_in "member[email]", with: "laura.gaga@gmail.com"
    click_button "Save Details"
  end

  def member_can_see_the_information_updated
    visit profile_path
    expect(page).to have_content("Laura Gaga")
    expect(page).to have_content("I'm terrible nice girl.")
    expect(page).to have_content("laura.gaga@gmail.com")    
  end
end