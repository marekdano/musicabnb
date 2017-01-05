FactoryGirl.define do
  factory :available_date do
    date Date.tomorrow
    booked false
    location nil
  end
end
