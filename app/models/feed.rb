class Feed < ActiveRecord::Base
  has_many :subscription,
           foreign_key: 'feed_id',
           dependent: :destroy
  has_many :users, through: :subscription

  has_many :feed_categorization,
           foreign_key: 'feed_id',
           dependent: :destroy
  has_many :categories, through: :feed_categorization

  validates :title, presence: true
  validates :url,
            presence: true,
            uniqueness: true,
            format: /\A#{URI::regexp(%w(http https))}\z/
end
