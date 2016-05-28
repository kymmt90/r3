class Feed < ActiveRecord::Base
  validates :title, presence: true
  validates :url, presence: true, format:  /\A#{URI::regexp(%w(http https))}\z/
end
