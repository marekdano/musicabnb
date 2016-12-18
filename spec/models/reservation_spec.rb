require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe "validations" do 
    it "has a valid factory" do
      expect(FactoryGirl.create(:reservation)).to be_valid
    end

    #it { should validate(:dates_are_available) }
  end

  describe "associations" do
    it { should belong_to(:location) }
    it { should belong_to(:member) }
  end
end
