class Category < ActiveRecord::Base
  belongs_to :user

  has_many :feed_categorization,
           foreign_key: 'category_id',
           dependent: :destroy
  has_many :feeds, through: :feed_categorization

  validates :name,
            presence: true,
            length: { maximum: 20 },
            uniqueness: { scope: :user_id, case_sensitive: false }
end
