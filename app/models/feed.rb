class Feed < ActiveRecord::Base
  has_many :subscriptions,
           foreign_key: 'feed_id',
           dependent: :destroy
  has_many :users, through: :subscriptions

  has_many :feed_categorizations,
           foreign_key: 'feed_id',
           dependent: :destroy
  has_many :categories, through: :feed_categorizations

  validates :title, presence: true
  validates :url,
            presence: true,
            uniqueness: true,
            format: /\A#{URI::regexp(%w(http https))}\z/
end
