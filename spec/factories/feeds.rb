require 'faker'

FactoryGirl.define do
  factory :feed do
    title { Faker::Name.title }
    url { Faker::Internet.url }

    factory :invalid_feed do
      title nil
    end
  end
end
