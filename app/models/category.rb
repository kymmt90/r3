class Category < ActiveRecord::Base
  belongs_to :user

  validates :name,
            presence: true,
            length: { maximum: 20 },
            uniqueness: { scope: :user_id, case_sensitive: false }
end
