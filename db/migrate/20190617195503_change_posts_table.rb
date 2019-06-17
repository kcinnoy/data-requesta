class ChangePostsTable < ActiveRecord::Migration
  def change
    change_table :posts do |t|
    t.column :category, :string
    end
  end
end
