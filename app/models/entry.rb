class Entry < ActiveRecord::Base
  belongs_to :feed

  validates :title, presence: true
  validates :url,
            presence: true,
            uniqueness: true,
            format: /\A#{URI::regexp(%w(http https))}\z/
  validates :published_at, presence: true
end
