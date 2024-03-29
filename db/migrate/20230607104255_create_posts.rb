class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.string :image
      t.integer :comments_counter
      t.integer :likes_counter
      t.date :posted_date

      t.timestamps
    end
  end
end
