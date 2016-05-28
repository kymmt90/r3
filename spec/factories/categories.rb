require 'faker'

FactoryGirl.define do
  factory :category do
    association :user
    name { Faker::Lorem.word }
  end
end
