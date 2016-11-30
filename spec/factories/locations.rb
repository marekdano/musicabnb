FactoryGirl.define do
  factory :location do
    title "MyString"
    description "MyText"
    address_1 "MyString"
    address_2 "MyString"
    city "MyString"
    state "MyString"
    postcode "MyString"
    musical_instrument "MyString"
    night_rate "9.99"
    guests 1
    member nil
  end
end
