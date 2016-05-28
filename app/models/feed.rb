class Feed < ActiveRecord::Base
  has_many :subscription,
           foreign_key: 'feed_id',
           dependent: :destroy

  has_many :users, through: :subscription

  validates :title, presence: true
  validates :url,
            presence: true,
            uniqueness: true,
            format: /\A#{URI::regexp(%w(http https))}\z/
end
