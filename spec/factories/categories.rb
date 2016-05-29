require 'faker'

FactoryGirl.define do
  factory :category do
    association :user
    name { Faker::Lorem.word }

    factory :invalid_category do
      name nil
    end
  end
end
