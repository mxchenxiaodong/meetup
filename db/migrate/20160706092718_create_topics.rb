class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :user_id,   null: false
      t.string :title,      null: false
      t.text :content,      null: false
      t.text :content_html
      t.integer :lock_version, default: 0

      t.timestamps null: false
    end
  end
end
