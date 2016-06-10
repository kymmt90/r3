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
            format: URL_REGEXP
  validates :feed_url,
            presence: true,
            uniqueness: true,
            format: URL_REGEXP

  def self.fetch(feed_url)
    return nil unless feed_url =~ URL_REGEXP
    self.fetch_and_save(feed_url)
  end

  def refresh
    Feed.fetch_and_save(feed_url)
  end


  private

  def self.fetch_and_save(feed_url)
    fetched_feed = Feedjira::Feed.fetch_and_parse(feed_url)
    feed = self.save_feed(fetched_feed)
    self.save_entries(feed, fetched_feed.entries)
    feed
  end

  def self.save_feed(fetched_feed)
    return Feed.find_by(url: fetched_feed.url) if Feed.exists?(url: fetched_feed.url)
    Feed.create(url: fetched_feed.url,
                feed_url: fetched_feed.feed_url,
                title: fetched_feed.title)
  end

  def self.save_entries(feed, fetched_entries)
    fetched_entries.each do |fetched_entry|
      next if Entry.exists?(url: fetched_entry.url)
      feed.entries.create(title: fetched_entry.title,
                          url: fetched_entry.url,
                          author: fetched_entry.author,
                          published_at: fetched_entry.published,
                          summary: fetched_entry.summary)
    end
  end
end
