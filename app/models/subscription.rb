class Subscription < ActiveRecord::Base
  belongs_to :feed
  belongs_to :user

  validates :feed,
            presence: true,
            uniqueness: { scope: :user }
  validates :user, presence: true
end
