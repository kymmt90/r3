require 'feedjira'

class Feed < ActiveRecord::Base
  has_many :entries

  has_many :subscriptions,
           foreign_key: 'feed_id',
           dependent: :destroy
  has_many :users, through: :subscriptions

  has_many :feed_categorizations,
           foreign_key: 'feed_id',
           dependent: :destroy
  has_many :categories, through: :feed_categorizations

  validates :title, presence: true

  URL_REGEXP = /\A#{URI::regexp(%w(http https))}\z/
  validates :url,
            presence: true,
            uniqueness: true,
            format: URL_REGEXP

  def self.fetch(url)
    return nil unless url =~ URL_REGEXP

    feed = Feedjira::Feed.fetch_and_parse(url)
    return Feed.find_by(url: feed.url) if Feed.exists?(url: feed.url)

    feed = Feed.new(url: feed.url, title: feed.title)
    feed.save ? feed : nil
  end
end
