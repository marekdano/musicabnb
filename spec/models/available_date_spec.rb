require 'rails_helper'

RSpec.describe AvailableDate, type: :model do
  describe "validations" do
    it "has a valid factory" do
      location = FactoryGirl.create(:location)
      expect(FactoryGirl.create(:available_date, location: location)).to be_valid
    end

    it { should validate_presence_of(:date) }
  end

  describe "#available_for_reservation" do
    it "returns available dates that can be reserved" do
      location = FactoryGirl.create(:location)
      available_date_today = FactoryGirl.create(:available_date, date: Date.today, location: location)
      available_date_tomorrow = FactoryGirl.create(:available_date, date: Date.tomorrow, location: location)

      date_range_array = (Date.today..(Date.today + 3.days)).to_a

      available_dates_to_be_reserved = AvailableDate.available_for_reservation(date_range_array)
      expect(available_dates_to_be_reserved.count).to eq 2
      expect(available_dates_to_be_reserved[0].date).to eq Date.today
      expect(available_dates_to_be_reserved[1].date).to eq Date.tomorrow
    end
  end

  describe "associations" do  
    it { should belong_to(:location) }
  end

end
