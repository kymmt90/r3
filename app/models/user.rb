class User < ActiveRecord::Base
  has_many :categories

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
