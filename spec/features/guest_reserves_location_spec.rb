require "rails_helper"

feature "Member reserves location" do
  let!(:location) { FactoryGirl.create(:location) }

  before do
    location.member.create_profile
    login_as(location.member, scope: :member)
  end

  scenario "by visiting location show page and selecting dates", js: true do
    visit location_path(location)
    expect(page).to have_content(location.title.upcase)

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

    expect(page).to have_content("Reservation successfully created.")
    expect(page).to have_content("THANK YOU FOR BOOKING THE PLACE!")
    
    expect(Reservation.count).to eq 1
    reservation = Reservation.last
    expect(reservation.location_id).to eq location.id
    expect(reservation.member_id).to eq location.member.id
    expect(reservation.start_date).to eq Date.tomorrow
    expect(reservation.end_date).to eq Date.today + 2.days
  end
end