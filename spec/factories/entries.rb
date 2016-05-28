require 'faker'

FactoryGirl.define do
  factory :entry do
    association :feed
    title { Faker::Name.title }
    url { Faker::Internet.url }
    author { Faker::Name.name }
    published_at { Faker::Date.between(1.year.ago, 1.year.from_now) }
    summary { Faker::Lorem.paragraph(10, true, 5) }
  end
end
