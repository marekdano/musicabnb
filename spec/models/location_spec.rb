require 'rails_helper'

RSpec.describe Location, type: :model do
  describe "validations" do 
    it "has a valid factory" do
      expect(FactoryGirl.create(:location)).to be_valid
    end

    it { should validate_presence_of(:member_id) }
    it { should validate_presence_of(:title) } 
    it { should validate_presence_of(:description) } 
    it { should validate_presence_of(:address_1) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:musical_instrument) }
    it { should validate_presence_of(:night_rate) }
    it { should validate_presence_of(:guests) }  
    it do
      should accept_nested_attributes_for(:location_images)
        .allow_destroy(true)
    end
  end

  describe "associations" do
    it { should belong_to(:member) }
    it { should have_many(:location_images)
      .dependent(:destroy) }
    it { should have_many(:available_dates)
      .dependent(:destroy) }
  end

  describe "#create_available_dates" do
    it "creates available dates for a date range for that location" do
      location = FactoryGirl.create(:location)
      start_date = (Date.tomorrow).to_s
      end_date = (Date.today + 2.days).to_s

      location.create_available_dates(start_date, end_date)

      expect(AvailableDate.count).to eq 3
      available_date = AvailableDate.last
      expect(available_date.location_id).to eq location.id
      expect(available_date.date).to eq Date.today + 2.days
      expect(available_date.booked).to eq false
    end
  end

  describe "#with_available_dates and #nearby" do
    it "returns Locations when address and dates range are defined" do
      location = FactoryGirl.create(:location)
      available_date_today = FactoryGirl.create(:available_date, date: Date.today, location: location)
      address = "Naas, Ireland"
      date_range_array = (Date.today..(Date.today + 3.days)).to_a

      locations = Location.nearby(address).with_available_dates(date_range_array)
      expect(locations.count(:all)).to eq 1
    end
  end

  describe "#nearby" do
    it "returns Locations within a defined address" do
      location = FactoryGirl.create(:location)
      address = "Naas, Ireland"

      locations = Location.nearby(address)
      expect(locations.count(:all)).to eq 1
    end
  end
  
end
