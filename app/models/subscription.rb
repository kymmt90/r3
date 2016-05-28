class Subscription < ActiveRecord::Base
  belongs_to :feed
  belongs_to :user

  validates :feed, presence: true
  validates :user, presence: true
end
