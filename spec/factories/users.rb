require 'faker'

FactoryGirl.define do
  factory :user do
    name { Faker::Internet.user_name[0...20] }
    email { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'

    factory :invalid_user do
      name nil
    end
  end
end
