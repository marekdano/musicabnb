require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe "validations" do
    it "has a valid factory" do 
      expect(FactoryGirl.create(:profile)).to be_valid
    end

    it { should validate_presence_of(:member_id) }
  end

  describe "associations" do
    it { should belong_to(:member) }
    it { should belong_to(:member).dependent(:destroy) }
  end
end
