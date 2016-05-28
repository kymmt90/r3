FactoryGirl.define do
  factory :subscription do
    association :feed
    association :user
  end
end
