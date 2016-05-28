class AddUserToCategories < ActiveRecord::Migration
  def change
    add_reference :categories, :user, index: true, foreign_key: true
    add_index :categories, [:user_id, :name], unique: true
  end
end
