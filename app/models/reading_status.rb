class ReadingStatus < ActiveRecord::Base
  belongs_to :user
  belongs_to :entry

  validates :entry,
            presence: true,
            uniqueness: { scope: :user }
  validates :user, presence: true

  enum status: [:unread, :read, :saved]
  validates :status, inclusion: { in: ReadingStatus.statuses.keys }
end
