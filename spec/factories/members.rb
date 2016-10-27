FactoryGirl.define do
  
  factory :member do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    password { Devise.friendly_token.first(6) }
  end

end
