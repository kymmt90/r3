class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title
      t.string :url

      t.timestamps null: false
    end
    add_index :feeds, :url, unique: true
  end
end
