include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :profile do
    bio "There something about me"
    member
    avatar { fixture_file_upload(Rails.root.join("spec", "fixtures", "files", "avatar.jpg"), "image/jpg") }
  end
end
