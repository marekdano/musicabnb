require "rails_helper"

feature "Member with profile" do
  let(:member) { FactoryGirl.create(:member) }
  
  before do 
    login_as(member, :scope => :member)
  end

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
    fill_in "member[email]", with: "laura.gaga@gmail.com"
    fill_in "member[profile_attributes][bio]", with: "I'm terrible nice girl."
    click_button "Save Details"
  end

  def member_can_see_the_information_updated
    expect(page).to have_content("Profile was updated successfully.") 
    expect(page).to have_content("I'm terrible nice girl.")   
  end


  #communicate purpose upfront with Simple BDD
  scenario "member can create own profile" do
    Given "member can view profile form"
    When "member enters incorrect email"
    Then "member can see a message of not saved information"
  end
  #define methods from scenario
  def member_can_view_profile_form
    login_as(member, :scope => :member)
    visit profile_path
    expect(page).to have_content("My Profile")
  end

  def member_enters_incorrect_email
    fill_in "member[email]", with: "laura.gagagmail.com"
    click_button "Save Details"
  end

  def member_can_see_a_message_of_not_saved_information
    expect(page).to have_content("Profile was not saved.")    
  end

  scenario "uploads a profile picture in correct format" do
    visit profile_path
    avatar_path = "spec/fixtures/files/avatar.jpg"
    attach_file "profile[avatar]", avatar_path
    click_button "Upload"
    expect(page).to have_content("Profile was updated successfully.")
    expect(page).to have_xpath("//img[contains(@src,'avatar.jpg')]")
    profile = Profile.last
    expect(profile).to have_attributes(avatar_file_name: a_value)
  end

  scenario "upload a profile picture in pdf format" do
    visit profile_path
    avatar_path = "spec/fixtures/files/sample.pdf"
    attach_file = "profile[avatar]", avatar_path
    click_button "Upload"
    expect(page).to have_content("Profile was not saved.")
  end

  scenario "hit Upload button without choosing a file" do
    visit profile_path
    click_button "Upload"
    expect(page).to have_content("Profile was not saved.")
  end

end

