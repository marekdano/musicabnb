FactoryGirl.define do

  factory :location do
    title "My title"
    description "My description"
    address_1 "1 Sundrive Road"
    address_2 "My address"
    city "Dublin"
    state "Ireland"
    postcode "My Postcode"
    musical_instrument "Drums"
    night_rate 23
    guests 1
    member
  end
end
