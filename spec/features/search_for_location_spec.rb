require 'rails_helper'

feature "Guest searches for locations" do
  let(:member) { FactoryGirl.create(:member) }  

  before do
    # location with available dates defined
    location_1 = FactoryGirl.create(:location, member: member)
    FactoryGirl.create(:available_date, date: Date.today, location: location_1)
    FactoryGirl.create(:available_date, date: Date.tomorrow, location: location_1)

    location_2 = FactoryGirl.create(:location, address_1: "27 5th Avenue", city: "New York", state: "USA", member: member) 

    # location with available dates defined
    location_3 = FactoryGirl.create(:location, member: member) 
    FactoryGirl.create(:available_date, date: Date.today, location: location_3)
    FactoryGirl.create(:available_date, date: Date.tomorrow, location: location_3)

    location_4 = FactoryGirl.create(:location, member: member) 
    location_5 = FactoryGirl.create(:location, member: member) 
    location_6 = FactoryGirl.create(:location, member: member) 
    location_7 = FactoryGirl.create(:location, member: member) 
    location_8 = FactoryGirl.create(:location, member: member) 
    location_9 = FactoryGirl.create(:location, member: member) 
    location_10 = FactoryGirl.create(:location, member: member) 
  end

  scenario "by place and date range" do
    visit root_path
    
    fill_in "address", with: "Dublin, Ireland"
    fill_in "start_date", with: Date.today
    fill_in "end_date", with: Date.tomorrow
    click_button "Find Properties"
   
    expect(page).to have_content("My title")
    expect(page.all('h2', :text => 'My title').count).to eq 2
  end
end