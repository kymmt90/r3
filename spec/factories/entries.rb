require 'faker'

FactoryGirl.define do
  factory :entry do
    association :feed
    sequence(:title) { |n| "Title #{n}" }
    sequence(:url) { |n| "http://example.com/entry/#{n}.xml" }
    author { Faker::Name.name }
    published_at { Faker::Date.between(1.year.ago, 1.year.from_now) }
    summary { Faker::Lorem.paragraph(10, true, 5) }
  end
end
