class CreateFeedCategorizations < ActiveRecord::Migration
  def change
    create_table :feed_categorizations do |t|
      t.references :category, index: true, foreign_key: true, null: false
      t.references :feed, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
    add_index :feed_categorizations, [:category_id, :feed_id], unique: true
  end
end
