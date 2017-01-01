require "rails_helper"

feature "Member reserves location" do
  let(:location) { FactoryGirl.create(:location) }
  let(:member) { FactoryGirl.create(:member) }

  before do
    login_as(member, scope: :member)
  end

  scenario "by visiting location show page and selecting dates", js: true do
    #visit locations_path(location)
    visit "locations/#{location.id}"
    #expect(page).to have_content location.description

    execute_script("
      $('#datepicker-start').datepicker(
        'setDate', new Date((new Date()).valueOf() + 1000*3600*24)); 
    ")
    #fill_in "reservation[start_date]", with: Date.tomorrow

    execute_script("
      $('#datepicker-end').datepicker(
        'setDate', new Date((new Date()).valueOf() + 1000*3600*48)); 
    ")
    #fill_in "reservation[end_date]", with: Date.today + 2.days 

    click_button "Reserve Location"
    
    expect(page).to have_content "Reservation summary"
    click_button "Confirm Reservation"

    expect(page).to have_content "Reservation successfully created."
    expect(page).to have_content "Thanks for booking the place!"
    
    expect(Reservation.count).to eq 1
    reservation = Reservation.last
    expect(reservation.location_id).to eq location.id
    expect(reservation.member_id).to eq member.id
    expect(reservation.start_date).to eq Date.tomorrow
    expect(reservation.end_date).to eq Date.today + 2.days
  end
end