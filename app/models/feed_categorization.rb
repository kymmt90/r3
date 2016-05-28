class FeedCategorization < ActiveRecord::Base
  belongs_to :category
  belongs_to :feed

  validates :category, presence: true
  validates :feed, presence: true
end
