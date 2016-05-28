FactoryGirl.define do
  factory :feed_categorization do
    association :category
    association :feed
  end
end
