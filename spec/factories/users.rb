FactoryGirl.define do
  factory :user do
    user_name {Faker::Internet.user_name()[0..6]}
    password_digest "MyStri"
    role 0
  end

end
