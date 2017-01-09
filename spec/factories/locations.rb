FactoryGirl.define do

  sequence :title do |n|
    "My title" + n.to_s
  end

  factory :location do
    title
    description FFaker::Lorem.paragraph(2)
    address_1 "1 Sundrive Road"
    address_2 "My address"
    city "Dublin"
    state "Ireland"
    postcode "My Postcode"
    musical_instrument "Drums"
    night_rate 23
    guests 1
    association :member, factory: :member
    
    factory :location_with_available_dates do
      after(:create) {|instance| create(:available_date, location: instance) }
      after(:create) {|instance| create(:available_date, location: instance, date: Date.today + 2.days) }
    end
  end
end
