class User < ActiveRecord::Base
  has_many :categories,
           dependent: :destroy

  has_many :subscriptions,
           foreign_key: 'user_id',
           dependent: :destroy
  has_many :feeds, through: :subscriptions

  has_many :reading_statuses,
           foreign_key: 'user_id',
           dependent: :destroy
  has_many :entries, through: :reading_statuses

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  attr_accessor :remember_token

  before_save :downcase_email

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(self.remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def subscribe?(feed)
    feeds.include?(feed)
  end

  def unread_count(feed)
    count = 0
    feed.entries.each do |entry|
      reading_status = ReadingStatus.find_by(user_id: self.id, entry_id: entry.id)
      count += reading_status.unread? ? 1 : 0
    end
    count
  end


  private

  def downcase_email
    self.email = email.downcase
  end
end
