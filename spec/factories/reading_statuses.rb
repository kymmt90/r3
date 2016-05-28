FactoryGirl.define do
  factory :reading_status do
    association :user
    association :entry
    status ReadingStatus.statuses[:unread]
  end
end
