class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :title
      t.string :url
      t.string :author
      t.date :published_at
      t.text :summary
      t.references :feed, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :entries, :url, unique: true
  end
end
