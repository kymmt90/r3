class Entry < ActiveRecord::Base
  belongs_to :feed

  has_many :reading_statuses,
           foreign_key: 'entry_id',
           dependent: :destroy
  has_many :users, through: :reading_statuses

  validates :title, presence: true
  validates :url,
            presence: true,
            uniqueness: true,
            format: /\A#{URI::regexp(%w(http https))}\z/
  validates :published_at, presence: true

  default_scope -> { order(published_at: :desc) }
end
