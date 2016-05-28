class CreateReadingStatuses < ActiveRecord::Migration
  def change
    create_table :reading_statuses do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :entry, index: true, foreign_key: true, null: false
      t.integer :status, unread: 0, null: false, limit: 2

      t.timestamps null: false
    end
    add_index :reading_statuses, [:user_id, :entry_id], unique: true
  end
end
