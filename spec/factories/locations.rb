FactoryGirl.define do

  factory :location do
    title "My title"
    description "My description"
    address_1 "My address"
    address_2 "My address"
    city "My City"
    state "My State"
    postcode "My Postcode"
    musical_instrument "My musical instrument"
    night_rate 23
    guests 1
    member
  end
end
