class AddPostedDateToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :posted_date, :date
  end
end
