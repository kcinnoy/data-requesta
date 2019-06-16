class CreateCategoryPosts < ActiveRecord::Migration
  def change
    create_table :category_posts do |t|
      t.string :category_id
      t.string :post_id
    end
  end
end
