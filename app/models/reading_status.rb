class ReadingStatus < ActiveRecord::Base
  belongs_to :user
  belongs_to :entry

  validates :user, presence: true
  validates :entry, presence: true

  enum status: [:unread, :read, :saved]
  validates :status, inclusion: { in: ReadingStatus.statuses.keys }
end
